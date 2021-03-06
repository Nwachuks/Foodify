//
//  Order.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import Foundation

struct Order: Decodable {
    let id: String?
    let name: String?
    let dish: Dish?
}
