//
//  HTTPUtility.swift
//  09/06/20.
//
//  Created by Puneet Mahajan on 09/06/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import Foundation
import UIKit

// Generic class for calling API
struct HTTPUtility {
    
    func request<T: Decodable>(url: URL, data: Data?, responseType: T.Type, method: HTTPMethod, completionHandler: @escaping (T?, ErrorResponse?) -> Void) {
        
        // Create url request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = data
        urlRequest.httpMethod = method.value
        
        // set header
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("en", forHTTPHeaderField: "Accept-Language")
        
        // Get URLSession instance
        let session = URLSession.shared
        
        // Perform task operation
        let task = session.dataTask(with: urlRequest) { (data, httpResponse, error) in
            
            guard let data = data, let httpResponse = httpResponse as? HTTPURLResponse else {
                completionHandler(nil, ErrorResponse(code: 500, message: error?.localizedDescription ?? "Something went wrong. Please try again"))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                debugPrint(httpResponse.url ?? "")
                let decodedObj = try decoder.decode(T.self, from: data)
                debugPrint(decodedObj)
                completionHandler(decodedObj, nil)
                
            } catch let error {
                debugPrint("\(error.localizedDescription)")
                debugPrint(httpResponse.url ?? "")
                
                completionHandler(nil, ErrorResponse(code: httpResponse.statusCode, message: error.localizedDescription))
            }
        }
        task.resume()
    }
    
}
