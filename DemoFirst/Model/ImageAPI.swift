//
//  ImageAPI.swift
//  DemoFirst
//
//  Created by chanda on 14/08/20.
//  Copyright © 2020 chanda. All rights reserved.
//

import UIKit
class ImageAPI{

    var images:UIImage?
    var task: URLSessionDataTask!
    
    func fecthes(from url:URL) -> UIImage?{
      images = nil
      if let task = task
     {
        task.cancel()
        }
        if let imageFromCache = imagCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            self.images = imageFromCache
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data,let newImage = UIImage(data: data)else{
                return
            }
            imagCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.images = newImage
            }
        }
        task.resume()
        return images
        }
}
