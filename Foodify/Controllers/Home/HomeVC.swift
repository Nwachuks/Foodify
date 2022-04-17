//
//  HomeVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 05/03/2022.
//

import UIKit
import SVProgressHUD

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    
    var categories = [DishCategory]()
    var popularDishes = [Dish]()
    var specials = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Foodify"
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        
        specialsCollectionView.delegate = self
        specialsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        registerCells()
        
        SVProgressHUD.show()
        NetworkManager.instance.fetchAllCategories { [weak self] (result) in
            switch result {
            case .success(let allDishes):
                SVProgressHUD.dismiss()
                self?.categories = allDishes.categories ?? []
                self?.popularDishes = allDishes.populars ?? []
                self?.specials = allDishes.specials ?? []
                
                DispatchQueue.main.async {
                    self?.categoryCollectionView.reloadData()
                    self?.popularCollectionView.reloadData()
                    self?.specialsCollectionView.reloadData()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    // MARK: CollectionView Delegate methods
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCVC.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCVC.identifier)
        popularCollectionView.register(UINib(nibName: PopularCVC.identifier, bundle: nil), forCellWithReuseIdentifier: PopularCVC.identifier)
        specialsCollectionView.register(UINib(nibName: SpecialsCVC.identifier, bundle: nil), forCellWithReuseIdentifier: SpecialsCVC.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return popularDishes.count
        case specialsCollectionView:
            return specials.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.identifier, for: indexPath) as! CategoryCVC
            cell.setup(categories[indexPath.row])
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCVC.identifier, for: indexPath) as! PopularCVC
            cell.setup(popularDishes[indexPath.row])
            return cell
        case specialsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialsCVC.identifier, for: indexPath) as! SpecialsCVC
            cell.setup(specials[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let controller = DishesListVC.instantiate(from: "Home")
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = DishDetailVC.instantiate(from: "Home")
            controller.dish = collectionView == popularCollectionView ? popularDishes[indexPath.row] : specials[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
