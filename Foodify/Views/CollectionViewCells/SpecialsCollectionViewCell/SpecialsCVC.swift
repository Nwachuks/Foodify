//
//  SpecialsCVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 03/04/2022.
//

import UIKit
import Kingfisher

class SpecialsCVC: UICollectionViewCell {
    static let identifier = String(describing: SpecialsCVC.self)
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTitleLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var dishCaloriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(_ dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        dishTitleLabel.text = dish.name
        dishDescriptionLabel.text = dish.description
        dishCaloriesLabel.text = dish.formattedCalories
    }
}
