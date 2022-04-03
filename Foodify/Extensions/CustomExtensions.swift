//
//  CustomExtensions.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 03/04/2022.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate(from storyboard: String) -> Self {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
