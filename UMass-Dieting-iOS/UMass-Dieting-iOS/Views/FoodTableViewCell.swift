//
//  FoodTableViewCell.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import Foundation
import UIKit
class FoodTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FoodTableViewCell"
    private let iconSize: CGFloat = 30
    var food: Food? = nil {
        didSet {
            foodTitle.attributedText = food?.dish_name?.withBoldText(text: food?.dish_name ?? "", fontSize: 18)
            foodSubTitle.text = food?.serving_size
//            configureSustainabilityImage(sustainabilityRating: food?.carbon_rating ?? "Unknown")
            loadTagImages()
        }
    }
    
    let foodTitle: UILabel = {
        let foodTitle = UILabel()
        foodTitle.numberOfLines = 1
        foodTitle.textAlignment = .left
        return foodTitle
    }()
    
    let foodSubTitle: UILabel = {
        let foodSubTitle = UILabel()
        foodSubTitle.textAlignment = .left
        return foodSubTitle
    }()
    
//    let sustainabilityImage: UIImageView = {
//        let sustainabilityImage = UIImageView()
//        sustainabilityImage.translatesAutoresizingMaskIntoConstraints = false
//        sustainabilityImage.image = UIImage(systemName: "leaf")
//        sustainabilityImage.tintColor = .green
//        return sustainabilityImage
//    }()
    
    let imagesStack: UIStackView = {
        let imagesStack = UIStackView()
        imagesStack.translatesAutoresizingMaskIntoConstraints = false
        imagesStack.axis = .horizontal
        imagesStack.distribution = .fill
        imagesStack.alignment = .center
        return imagesStack
    }()
    
    let labelsStack: UIStackView = {
        let labelsStack = UIStackView()
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.axis = .vertical
        labelsStack.distribution = .fill
        labelsStack.alignment = .leading
        labelsStack.spacing = 0
        return labelsStack
    }()
    
    let leftStack: UIStackView = {
        let leftStack = UIStackView()
        leftStack.spacing = 15
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        leftStack.axis = .horizontal
        leftStack.alignment = .leading
        leftStack.distribution = .fillProportionally
        return leftStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leftStack)
        
        leftStack.addArrangedSubview(imagesStack)
        leftStack.addArrangedSubview(labelsStack)
                
        labelsStack.addArrangedSubview(foodTitle)
        labelsStack.addArrangedSubview(foodSubTitle)
        
        labelsStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

        imagesStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        leftStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        leftStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        leftStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10).isActive = true
        leftStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true

        leftStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSustainabilityImage(sustainabilityRating: String) {
        let icon: UIImageView = UIImageView(image: UIImage(systemName: "a.circle.fill"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        icon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true

        if (sustainabilityRating == "A") {
            icon.image = UIImage(systemName: "a.circle.fill")
            icon.tintColor = .systemGreen
            
        } else if (sustainabilityRating == "B") {
            icon.image = UIImage(systemName: "b.circle.fill")
            icon.tintColor = UIColor(hexString: "6cf542")
            
        } else if (sustainabilityRating == "C") {
            icon.image = UIImage(systemName: "c.circle.fill")
            icon.tintColor = .systemYellow
            
        } else if (sustainabilityRating == "D") {
            icon.image = UIImage(systemName: "d.circle.fill")
            icon.tintColor = .systemOrange
            
        } else if (sustainabilityRating == "E") {
            icon.image = UIImage(systemName: "e.circle.fill")
            icon.tintColor = .systemRed
        } else {
            return
        }

        imagesStack.addArrangedSubview(icon)
    }
    
    func loadTagImages() {
        guard let food = self.food else {
            fatalError("$ERROR: Food is nil")
        }
        for view in imagesStack.subviews{
            view.removeFromSuperview()
        }
//        print("Sustainability rating: \(sustainabilityRating)")
        configureSustainabilityImage(sustainabilityRating: food.carbon_rating ?? "")
                
        if let tags = food.tags {
            
            
            if (tags.contains(K.vegTag)) {
                let vegetarianIcon: UIImageView = UIImageView(image: K.vegetarianImage)
                vegetarianIcon.translatesAutoresizingMaskIntoConstraints = false
                vegetarianIcon.tintColor = .systemGreen
                imagesStack.addArrangedSubview(vegetarianIcon)
                vegetarianIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
                vegetarianIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            }
            
            if (tags.contains(K.localTag)) {
                let localIcon: UIImageView = UIImageView(image: K.localImage)
                localIcon.translatesAutoresizingMaskIntoConstraints = false
                localIcon.tintColor = .orange
                imagesStack.addArrangedSubview(localIcon)
                localIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
                localIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            }
            
            if (tags.contains(K.halalTag)) {
                let localIcon: UIImageView = UIImageView(image: K.halalImage)
                localIcon.translatesAutoresizingMaskIntoConstraints = false
                localIcon.tintColor = .systemPurple
                imagesStack.addArrangedSubview(localIcon)
                localIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
                localIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            }
            
            if (tags.contains(K.sustainableTag)) {
                let localIcon: UIImageView = UIImageView(image: K.sustainableImage)
                localIcon.translatesAutoresizingMaskIntoConstraints = false
                localIcon.tintColor = .systemGreen
                imagesStack.addArrangedSubview(localIcon)
                localIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
                localIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            }
            
            if (tags.contains(K.wholeGrainTag)) {
                let localIcon: UIImageView = UIImageView(image: K.wholeGrainImage)
                localIcon.translatesAutoresizingMaskIntoConstraints = false
                localIcon.tintColor = .systemYellow
                imagesStack.addArrangedSubview(localIcon)
                localIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
                localIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            }
            
            if (tags.contains(K.antibioticFreeTag)) {
                let localIcon: UIImageView = UIImageView(image: K.antibioticFreeImage)
                localIcon.translatesAutoresizingMaskIntoConstraints = false
                localIcon.tintColor = .systemBlue
                imagesStack.addArrangedSubview(localIcon)
                localIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
                localIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            }
        }
    }
    
}
