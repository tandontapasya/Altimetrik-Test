//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

protocol SearchServiceProtocol {
    func search(query: String,completionHandler:@escaping ([Album]?, Error?) -> Void)
}

class SearchService: SearchServiceProtocol {
    var dataTask:URLSessionDataTask?
    
    func search(query: String,completionHandler:@escaping ([Album]?, Error?) -> Void) {
        if self.dataTask != nil {
            self.dataTask!.cancel()
        }
        OverlayActivityIndicator.sharedInstance.showOverlayView()
        guard let url = URL(string: "http://itunes.apple.com/search?term=\(query.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)" + "&country=us&entity=software&limit=100") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                OverlayActivityIndicator.sharedInstance.hideOverlayView()
            }

            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    completionHandler(nil,error)
                    return
            }
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                completionHandler(nil,error)
                return
            }
            let searchResults = SearchResultParser().parseSearchResults(searchResultData:data)
            completionHandler(searchResults?.results,nil)
        }
        self.dataTask?.resume()
    }
}
