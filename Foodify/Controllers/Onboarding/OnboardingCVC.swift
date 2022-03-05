//
//  OnboardingCVC.swift
//  Foodify
//
//  Created by Nwachukwu Ejiofor on 05/03/2022.
//

import UIKit

class OnboardingCVC: UICollectionViewCell {
    static let identifier = String(describing: OnboardingCVC.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = UIImage(named: slide.image)
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
