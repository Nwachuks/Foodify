//
//  PopularCVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 02/04/2022.
//

import UIKit

class PopularCVC: UICollectionViewCell {
    static let identifier = String(describing: PopularCVC.self)
    
    @IBOutlet weak var dishTitleLabel: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishCaloriesLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(_ dish: Dish) {
        dishTitleLabel.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        dishCaloriesLabel.text = dish.formattedCalories
        dishDescriptionLabel.text = dish.description
    }
}
