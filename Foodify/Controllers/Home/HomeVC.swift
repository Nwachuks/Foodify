//
//  HomeVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 05/03/2022.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "Africa Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id2", name: "Africa Dish 2", image: "https://picsum.photos/100/200"),
        .init(id: "id3", name: "Africa Dish 3", image: "https://picsum.photos/100/200"),
        .init(id: "id4", name: "Africa Dish 4", image: "https://picsum.photos/100/200"),
        .init(id: "id5", name: "Africa Dish 5", image: "https://picsum.photos/100/200")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Foodify"
        // Do any additional setup after loading the view.
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        registerCells()
    }
    
    // MARK: CollectionView Delegate methods
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCVC.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCVC.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.identifier, for: indexPath) as! CategoryCVC
        cell.setup(categories[indexPath.row])
        return cell
    }
    
}
