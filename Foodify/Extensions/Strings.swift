//
//  Strings.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 05/03/2022.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
