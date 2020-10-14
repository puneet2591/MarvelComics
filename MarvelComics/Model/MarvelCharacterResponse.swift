//
//  MarvelCharacterResponse.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 09/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import Foundation

// Model for marvel character
struct MarvelCharactersResponse: BaseProtocol {
    
    var code: Int
    var status: String
    var data: MarvelCharacterList
    
}

struct MarvelCharacterList : Decodable {
    
    var results: [MarvelCharacterData]
}


struct MarvelCharacterData : Decodable {
    
    var id: Int
    var name: String
    var description: String?
    var thumbnail: MarvelComicThumbnail
    var comics: Comics
    var series: Series
    var stories: Stories
    
    func getThumbnailUrl() -> URL? {
        
        return URL(string: "\(thumbnail.path)/landscape_incredible.\(thumbnail.ext)")
    }
}

struct Comics: Decodable {
    
    var items: [Items]
}

struct Series: Decodable {
    
    var items: [Items]
}

struct Stories: Decodable {
    
    var items: [Items]
}


struct Items : Decodable {
    
    var name, resourceUrl: String
    
    enum CodingKeys: String, CodingKey {
        
        case name
        case resourceUrl = "resourceURI"
    }
}
