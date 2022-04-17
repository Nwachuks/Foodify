//
//  DishesListVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import UIKit
import SVProgressHUD

class DishesListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dishesListTableView: UITableView!
    
    var category: DishCategory!
    var dishes = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishesListTableView.delegate = self
        dishesListTableView.dataSource = self
        // Do any additional setup after loading the view.
        title = category.title
        registerCells()
        
        SVProgressHUD.show()
        NetworkManager.instance.fetchCategoryDishes(categoryID: category.id) { [weak self] result in
            switch result {
            case .success(let dishes):
                SVProgressHUD.dismiss()
                self?.dishes = dishes
                DispatchQueue.main.async {
                    self?.dishesListTableView.reloadData()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    private func registerCells() {
        dishesListTableView.register(UINib(nibName: DishListTVC.identifier, bundle: nil), forCellReuseIdentifier: DishListTVC.identifier)
    }
    
    // MARK: TableViewDelegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTVC.identifier) as! DishListTVC
        cell.setup(dish: dishes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailVC.instantiate(from: "Home")
        controller.dish = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
