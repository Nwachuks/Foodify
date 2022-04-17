//
//  DishDetailVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 03/04/2022.
//

import UIKit
import Kingfisher
import SVProgressHUD

class DishDetailVC: UIViewController {
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTitleLabel: UILabel!
    @IBOutlet weak var dishCaloriesLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    var dish: Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupDish()
    }
    
    private func setupDish() {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        dishTitleLabel.text = dish.name
        dishDescriptionLabel.text = dish.description
        dishCaloriesLabel.text = dish.formattedCalories
    }
    
    @IBAction func placeOrderTapped(_ sender: UIButton) {
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            SVProgressHUD.showError(withStatus: "Please enter your name")
            return
        }
        
        SVProgressHUD.show(withStatus: "Placing order...")
        NetworkManager.instance.placeOrder(dishID: dish.id ?? "", name: name) { result in
            switch result {
            case .success(_):
                SVProgressHUD.showSuccess(withStatus: "Your order has been successfully placed 🥳")
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
}
