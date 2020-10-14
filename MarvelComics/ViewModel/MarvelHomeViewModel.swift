//
//  MarvelHomeViewModel.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 14/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import Foundation

// MarvelHomeViewModel view model

struct MarvelHomeViewModel : ViewModelProtocol {
    
    var httpUtility: HTTPUtility = HTTPUtility()
    weak var loaderDelegate: LoaderProtocol?
    private weak var outputDelegate: MarvelHomeOutputProtocol?
    weak var errorDelegate: ErrorProtocol?
    
    init(delegate: MarvelHomeOutputProtocol) {
        self.outputDelegate = delegate
    }
    
}

//MARK: - API Call

extension MarvelHomeViewModel {
    
    func getMarvelComicsList() {
        
        // create url request
        var urlComponent = URLComponents(url: URL(string: Endpoints.GetMarvelComicsList)!, resolvingAgainstBaseURL: false)
        
        urlComponent?.queryItems = [URLQueryItem(name: "ts", value: "1"),
                                    URLQueryItem(name: "apikey", value: APIKeys.MarvelApiKey),
                                    URLQueryItem(name: "hash", value: APIKeys.MarvelHashKey),
                                    URLQueryItem(name: "limit", value: "100")]
        
        // show loader
        self.loaderDelegate?.showLoader(show: true)
        
        httpUtility.request(url: (urlComponent?.url)!, data: nil, responseType: MarvelComicsResponse.self, method: .get) { (comicsResponse, error) in
            
            // hide loader
            self.loaderDelegate?.showLoader(show: false)
            
            // check response is nil
            if let comicsResponse = comicsResponse {
                
                if comicsResponse.code == 200 {
                    self.outputDelegate?.didReceiveMarvelComics(data: comicsResponse)
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
