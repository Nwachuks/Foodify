//
//  AppError.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidURL
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "No idea what's wrong"
        case .invalidURL:
            return "URL is invalid"
        case .serverError(let error):
            return error
        }
    }
}
