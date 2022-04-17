//
//  DishListTVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import UIKit

class DishListTVC: UITableViewCell {
    static let identifier = String(describing: DishListTVC.self)
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTitleLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        dishTitleLabel.text = dish.name
        dishDescriptionLabel.text = dish.description
    }
    
    func setup(order: Order) {
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
        dishTitleLabel.text = order.dish?.name
        dishDescriptionLabel.text = order.name
    }
    
}
