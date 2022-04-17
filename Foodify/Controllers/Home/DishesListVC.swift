//
//  DishesListVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import UIKit

class DishesListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dishesListTableView: UITableView!
    
    var category: DishCategory!
    
    var dishes: [Dish] = [
        .init(id: "id1", name: "Garri", image: "https://picsum.photos/100/200", description: "The best cassava flakes you ever tasted", calories: 34),
        .init(id: "id2", name: "Indomie", image: "https://picsum.photos/100/200", description: "The best cassava flakes you ever tasted The best cassava flakes you ever tasted The best cassava flakes you ever tasted The best cassava flakes you ever tasted The best cassava flakes you ever tasted The best cassava flakes you ever tasted The best cassava flakes you ever tasted", calories: 334),
        .init(id: "id3", name: "Pizza", image: "https://picsum.photos/100/200", description: "The best cassava flakes you ever tasted", calories: 34456)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishesListTableView.delegate = self
        dishesListTableView.dataSource = self
        // Do any additional setup after loading the view.
        title = category.name
        registerCells()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {b
        let controller = DishDetailVC.instantiate(from: "Home")
        controller.dish = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
