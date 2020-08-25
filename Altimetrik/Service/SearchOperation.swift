//
//  SearchOperation.swift
//  SingularTest
//
//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

class SearchOperation: AsyncOperation {
    var query:String = ""
    override func execute() {
        print(query)
//        let url = URL(string: "http://itunes.apple.com/search?term=Gameloft&country=us&entity=software&limit=100")!

       // http://itunes.apple.com/search?term=Gameloft&country=us&entity=software&limit=100
        let url = URL(string: "http://itunes.apple.com/search/term=\(query.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!) + &country=us&entity=software&limit=100")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let dict = try? JSONDecoder().decode(SearchResults.self, from: data)
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }

        task.resume()

    }
}
