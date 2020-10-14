//
//  AppProtocol.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 09/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import Foundation

protocol BaseProtocol: Decodable {
    
    var code: Int { get }
    var status: String { get }
}


//protocol for view model, this is the initial setup for view model
protocol ViewModelProtocol {
    var httpUtility: HTTPUtility { get set }
}

// Error protocol, if we find any error

protocol ErrorProtocol: class {
    func didReceiveError(error: ErrorResponse?)
}

protocol LoaderProtocol: class {
    func showLoader(show: Bool)
}

// Marvel Home protocol

protocol MarvelHomeOutputProtocol: class {
    
    func didReceiveMarvelComics(data: MarvelComicsResponse)
}

// Marvel character list output protocol
protocol MarvelCharacterListOutputProtocol: class {
    
    func didReceiveMarvelCharacters(data: MarvelCharactersResponse)
}
