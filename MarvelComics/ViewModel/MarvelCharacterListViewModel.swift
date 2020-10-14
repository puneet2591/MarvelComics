//
//  MarvelCharacterListViewModel.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 14/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import Foundation


struct MarvelCharacterListViewModel : ViewModelProtocol {
    
    var httpUtility: HTTPUtility = HTTPUtility()
    weak var loaderDelegate: LoaderProtocol?
    private weak var outputDelegate: MarvelCharacterListOutputProtocol?
    weak var errorDelegate: ErrorProtocol?
    
    init(delegate: MarvelCharacterListOutputProtocol) {
        self.outputDelegate = delegate
    }
    
}


extension MarvelCharacterListViewModel {
    
    func getMarvelCharactersList() {
        
        // create url request
        var urlComponent = URLComponents(url: URL(string: Endpoints.GetMarvelCharactersList)!, resolvingAgainstBaseURL: false)
        
        urlComponent?.queryItems = [URLQueryItem(name: "ts", value: "1"),
                                    URLQueryItem(name: "apikey", value: APIKeys.MarvelApiKey),
                                    URLQueryItem(name: "hash", value: APIKeys.MarvelHashKey)]
        
        // show loader
        self.loaderDelegate?.showLoader(show: true)
        
        httpUtility.request(url: (urlComponent?.url)!, data: nil, responseType: MarvelCharactersResponse.self, method: .get) { (comicsResponse, error) in
                
            // hide loader
            self.loaderDelegate?.showLoader(show: false)
            
            // check response is nil
            if let comicsResponse = comicsResponse {
                
                if comicsResponse.code == 200 {
                    self.outputDelegate?.didReceiveMarvelCharacters(data: comicsResponse)
                } else {
                    
                    // show error to user
                    self.errorDelegate?.didReceiveError(error: error)
                }
                
            }  else {
                self.errorDelegate?.didReceiveError(error: error)
            }
        }
    }
}
