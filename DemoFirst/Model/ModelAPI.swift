//
//  ModelAPI.swift
//  DemoFirst
//
//  Created by chanda on 13/08/20.
//  Copyright © 2020 chanda. All rights reserved.
//

import UIKit

final class ModelAPI{
    
    var DemoList:[DemoAPI] = []
    static let shared = ModelAPI()
    
    func fetchData(onCompletion:@escaping ([DemoAPI])->()){

        var urlString = "https://picsum.photos/v2/list?page=2&limit=20"
                   let url = URL(string: urlString)
                   let task = URLSession.shared.dataTask(with: url!) { (data, resp, error) in
                       guard let data = data else{
                        print("\(error)")
                           return
                       }
                    guard let demoList = try? JSONDecoder().decode([DemoAPI].self, from: data) else{ 
                        print("Couldnt decode json")
                        return
                    }
                
                    onCompletion(demoList)
                //   print(demoList)
                   }

                task.resume()
            }
    
    
}
    
