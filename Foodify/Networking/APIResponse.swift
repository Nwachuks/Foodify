//
//  APIResponse.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
