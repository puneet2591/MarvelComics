//
//  Constant.swift
//
//  Created by Puneet Mahajan on 26/08/20..
//  Copyright © 2020 Puneet. All rights reserved.
//

import UIKit

let AppName = "MarvelComics"

struct APIKeys {
    
    static let MarvelApiKey = "edcd17b470f95edac16fc34956118a78"
    static let MarvelHashKey = "849bea7e6c188edc4d03da05eefad1a0"
}

// Enum for storyboard constant and the instance of view controller
// If you have more storyboard, just add in this enum only ( make sure with exact name )

enum StoryboardConstant: String {
    
    case Main
    
    var instance: UIStoryboard {
        get {
            return UIStoryboard(name: self.rawValue, bundle: nil)
        }
    }
    
    func viewController<T: UIViewController>(type: T.Type) -> T? {
        return instance.instantiateViewController(withIdentifier: type.identifier) as? T
    }
}


// Enum for custom httpmethod
enum HTTPMethod: String {
    
    case post
    case get
    case delete
    case update
    case put
    
    var value: String {
        get {
            return rawValue
        }
    }
}

// Structure for Error response coming from API

struct ErrorResponse: Error {
    let response: APIResponse
    let message: String
}

// Structure for API url

struct Endpoints {
    
    static let GetMarvelComicsList = "https://gateway.marvel.com/v1/public/comics"
    static let GetMarvelCharactersList = "https://gateway.marvel.com/v1/public/characters"
    
}



enum APIResponse : Int {
    
    case ResponseOK = 200
    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case InterServerError = 500
    case BadGateway = 502
    case CouldNotConnectToServer = 501
    case ValidationError = 201
    case NoList = 202
    
    var value: String {
        
        switch self {
        case .BadRequest:
            return "Bad Request"
            
        case .Unauthorized:
            return "Unauthorozed"
            
        case .Forbidden:
            return "Forbidden"
            
        case .NotFound:
            return "Not found"
            
        case .InterServerError:
            return "Internal server error"
            
        case .BadGateway:
            return "Bad Gateway"
            
        case .CouldNotConnectToServer:
            return "Could not connect to server"
            
        default:
            return "Not found"
        }
    }
}
