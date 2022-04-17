//
//  NetworkManager.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import Foundation

struct NetworkManager {
    static let instance = NetworkManager()
    
    private init() {}
    
    func firstRequest() {
        request(route: .temp, method: .get, parameters: nil, type: String.self) { _ in
            //
        }
    }
    
    private func request<T: Codable>(route: RequestRoute, method: RequestMethod, parameters: [String:Any]? = nil, type: T.Type, completion: (Result<T, Error>) -> Void) {
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
                print("The response is:\n\(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                 
            }
        }.resume()
    }
    
    /// Create URL request
    /// - Parameters:
    ///   - route: The resource path on the backend
    ///   - method: The resource path method type
    ///   - parameters: The optional request body
    /// - Returns: A URLRequest
    private func createRequest(route: RequestRoute, method: RequestMethod, parameters: [String:Any]? = nil) -> URLRequest? {
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