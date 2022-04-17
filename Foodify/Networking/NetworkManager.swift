//
//  NetworkManager.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import Foundation

struct NetworkManager {
    /// Create URL request
    /// - Parameters:
    ///   - route: The resource path on the backend
    ///   - method: The resource path method type
    ///   - parameters: The optional request body
    /// - Returns: A URLRequest
     func createRequest(route: RequestRoute, method: RequestMethod, parameters: [String:Any]? = nil) -> URLRequest? {
        let urlString = RequestRoute.baseURL + route.description
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponent?.url
            case .post, .patch, .delete:
                let body = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = body
            }
        }
        return urlRequest
    }
}
