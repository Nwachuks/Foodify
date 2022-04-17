//
//  HomeVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 05/03/2022.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "Africa Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id2", name: "Africa Dish 2", image: "https://picsum.photos/100/200"),
        .init(id: "id3", name: "Africa Dish 3", image: "https://picsum.photos/100/200"),
        .init(id: "id4", name: "Africa Dish 4", image: "https://picsum.photos/100/200"),
        .init(id: "id5", name: "Africa Dish 5", image: "https://picsum.photos/100/200")
    ]
    
    var popularDishes: [Dish] = [
        .init(id: "id1", name: "Garri", image: "https://picsum.photos/100/200", description: "The best cassava flakes you ever tasted", calories: 34),
        .init(id: "id2", name: "Indomie", image: "https://picsum.photos/100/200", description: "The best cassava flakes you ever tasted The best cassava flakes you ever tasted The best cassava flakes you ever tasted The best cassava flakes you ever tasted The best cassava flakes you ever tasted The best cassava flakes you ever tasted The best cassava flakes you ever tasted", calories: 334),
        .init(id: "id3", name: "Pizza", image: "https://picsum.photos/100/200", description: "The best cassava flakes you ever tasted", calories: 34456)
    ]
    
    var specials: [Dish] = [
        .init(id: "id1", name: "Fried Plantain", image: "https://picsum.photos/100/200", description: "The best plantain you ever tasted", calories: 35),
        .init(id: "id2", name: "Beans and Garri", image: "https://picsum.photos/100/200", description: "The best combo you ever tasted", calories: 333)
    ]
    
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
        NetworkManager.instance.firstRequest()
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
