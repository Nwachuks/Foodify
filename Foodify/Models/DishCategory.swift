//
//  DishCategory.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 05/03/2022.
//

import Foundation

struct DishCategory: Decodable {
    let id: String
    let title: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
    }
}
