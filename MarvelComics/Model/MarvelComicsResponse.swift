//
//  MarvelComicsResponse.swift
//  SmartMonitor_iOS
//
//  Created by Puneet Mahajan on 09/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import Foundation


struct MarvelComicsResponse: BaseProtocol {
    
    var code: Int
    var status: String
    var data: MarvelComicList
    
}

struct MarvelComicList : Decodable {
    
    var results: [MarvelComicData]
}


struct MarvelComicData : Decodable {
    
    var id: Int
    var title: String
    var description: String?
    var thumbnail: MarvelComicThumbnail
    
    func getThumbnailUrl() -> URL? {
        
        return URL(string: "\(thumbnail.path)/portrait_xlarge.\(thumbnail.ext)")
    }
}

struct MarvelComicThumbnail : Decodable {
    
    var path: String
    var ext: String
    
    enum CodingKeys: String, CodingKey {
        
        case path
        case ext = "extension"
    }
}
