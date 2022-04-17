//
//  OrdersListVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import UIKit

class OrdersListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ordersTableView: UITableView!
    
    var orders: [Order] = [
        .init(id: "id1", name: "Emmanuel", dish: .init(id: "id1", name: "Garri", image: "https://picsum.photos/100/200", description: "The best cassava flakes you ever tasted", calories: 34)),
        .init(id: "id1", name: "Faith", dish: .init(id: "id1", name: "Beans", image: "https://picsum.photos/100/200", description: "The best cassava flakes you ever tasted", calories: 34)),
        .init(id: "id1", name: "Michael", dish: .init(id: "id1", name: "Rice", image: "https://picsum.photos/100/200", description: "The best cassava flakes you ever tasted", calories: 34)),
        .init(id: "id1", name: "John", dish: .init(id: "id1", name: "Yam", image: "https://picsum.photos/100/200", description: "The best cassava flakes you ever tasted", calories: 34))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        // Do any additional setup after loading the view.
        registerCells()
    }
    
    private func registerCells() {
        ordersTableView.register(UINib(nibName: DishListTVC.identifier, bundle: nil), forCellReuseIdentifier: DishListTVC.identifier)
    }
    
    // MARK: TableViewDelegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTVC.identifier) as! DishListTVC
        cell.setup(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailVC.instantiate(from: "Home")
        controller.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }

}
