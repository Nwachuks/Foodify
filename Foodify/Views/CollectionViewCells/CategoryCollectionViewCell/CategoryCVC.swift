//
//  CategoryCVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 05/03/2022.
//

import UIKit
import Kingfisher

class CategoryCVC: UICollectionViewCell {
    static let identifier = String(describing: CategoryCVC.self)
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    func setup(_ category: DishCategory) {
        categoryTitleLabel.text = category.name
        categoryImageView.kf.setImage(with: category.image.asUrl)
    }
}
