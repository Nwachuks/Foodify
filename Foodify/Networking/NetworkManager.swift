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
    
    func fetchAllCategories(completion: @escaping(Result<AllDishes, Error>) -> Void) {
        request(route: .fetchAllCategories, method: .get, completion: completion)
    }
    
    func placeOrder(dishID: String, name: String, completion: @escaping(Result<Order, Error>) -> Void) {
        let params = ["name": name]
        
        request(route: .placeOrder(dishID), method: .post, parameters: params, completion: completion)
    }
    
    func fetchCategoryDishes(categoryID: String, completion: @escaping(Result<[Dish], Error>) -> Void) {
        request(route: .fetchCategoryDishes(categoryID), method: .get, completion: completion)
    }
    
    func fetchOrders(completion: @escaping(Result<[Order], Error>) -> Void) {
        request(route: .fetchOrders, method: .get, completion: completion)
    }
    
    private func request<T: Decodable>(route: RequestRoute, method: RequestMethod, parameters: [String:Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let _ = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
//                print("The response is:\n\(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }

        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(APIResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
            if let decodedData = response.data  {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.unknownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
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
