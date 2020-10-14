//
//  MarvelComicsResponse.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 09/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import Foundation

// Model for marvel comics response

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
        
        // in order to get image from server just pass portrait_xlarge, portrait_medium
        // refer this doc: https://developer.marvel.com/documentation/images
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
