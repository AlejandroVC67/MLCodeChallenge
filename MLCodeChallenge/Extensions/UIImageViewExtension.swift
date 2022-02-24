//
//  UIImageViewExtension.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

extension UIImageView {
    var aspectRatio: CGFloat {
        guard let image = self.image,
              image.size.width > 0 else {
            return 0
        }
        return image.size.height / image.size.width
    }
    
    func downloadImage(from path: String?) {
        guard let path = path,
              let url = URL(string: path) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        
        if let data = cache.cachedResponse(for: request)?.data {
            let image = UIImage(data: data)
            self.image = image
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, _) in
            guard let data = data,
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                let cachedData = CachedURLResponse(response: response!, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                self.image = image
            }
        }
        task.resume()
    }
}

var cache: URLCache = .init()

func getCachedImage(from path: String) -> UIImage? {
    guard let url = URL(string: path) else {
        return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = HTTPMethods.get.rawValue
    
    if let data = cache.cachedResponse(for: request)?.data {
        return UIImage(data: data)
    }
    return nil
}
