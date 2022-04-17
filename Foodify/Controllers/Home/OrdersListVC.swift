//
//  OrdersListVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 17/04/2022.
//

import UIKit
import SVProgressHUD

class OrdersListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ordersTableView: UITableView!
    
    var orders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        // Do any additional setup after loading the view.
        registerCells()
        
        SVProgressHUD.show()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.instance.fetchOrders { [weak self] result in
            switch result {
            case .success(let orders):
                SVProgressHUD.dismiss()
                self?.orders = orders
                DispatchQueue.main.async {
                    self?.ordersTableView.reloadData()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
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
