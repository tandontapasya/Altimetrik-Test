//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - UIImageView extension
extension UIImageView {
    
    /// This loadThumbnail function is used to download thumbnail image using urlString
    /// This method also using cache of loaded thumbnail using urlString as a key of cached thumbnail.
    func loadThumbnail(urlSting: String) {
        guard let url = URL(string: urlSting) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler:{ [weak self] data , response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let imageToCache = UIImage(data: data) else { return }
            imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)

            DispatchQueue.main.async() {
                self?.image = UIImage(data: data)
            }

        }).resume()
    }
}

extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}

extension Array where Element: Equatable {
    mutating func removeObject<T>(obj: T) where T : Equatable {
        self = self.filter({$0 as? T != obj})
    }
}
