//
//  RequestRoute.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import Foundation

enum RequestRoute {
    static let baseURL = "https://yummie.glitch.me"
    
    case temp
    
    var description: String {
        switch self {
        case .temp:
            return "/temp"
        }
    }
}
