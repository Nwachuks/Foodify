//
//  Dish.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 02/04/2022.
//

import Foundation

struct Dish {
    let id, name, image, description: String?
    let calories: Int?
    
    var formattedCalories: String {
        return String(format: "\(calories ?? 0) calories")
    }
}
