//
//  DemoAPI.swift
//  DemoFirst
//
//  Created by chanda on 13/08/20.
//  Copyright © 2020 chanda. All rights reserved.
//

import UIKit

struct DemoAPI:Codable{
    
    let author:String?
    let id:String?
    let downloadurl:String?
   

    enum CodingKeys: String, CodingKey {
        case author
        case id
        case downloadurl = "download_url"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        downloadurl = try values.decodeIfPresent(String.self, forKey: .downloadurl)
    }
    
    
}
