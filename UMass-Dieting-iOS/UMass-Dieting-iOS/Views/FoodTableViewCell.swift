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
            foodTitle.attributedText = food?.name.withBoldText(text: food?.name ?? "", fontSize: 18)
            foodSubTitle.text = food?.servingString
            configureSustainabilityImage(sustainabilityRating: food?.carbonFootprint ?? 0)
            loadTagImages()
//            sustainabilityImage
        }
    }
    
    let foodTitle: UILabel = {
        let foodTitle = UILabel()
        return foodTitle
    }()
    
    let foodSubTitle: UILabel = {
        let foodSubTitle = UILabel()
        
        return foodSubTitle
    }()
    
    let sustainabilityImage: UIImageView = {
        let sustainabilityImage = UIImageView()
        sustainabilityImage.translatesAutoresizingMaskIntoConstraints = false
        sustainabilityImage.image = UIImage(systemName: "leaf")
        sustainabilityImage.tintColor = .green
        return sustainabilityImage
    }()
    
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
        labelsStack.distribution = .fillProportionally
//        labelsStack.alignment = .center
        labelsStack.spacing = 0
        return labelsStack
    }()
    
    let leftStack: UIStackView = {
        let leftStack = UIStackView()
        leftStack.spacing = 15
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        leftStack.axis = .horizontal
        leftStack.alignment = .leading
        leftStack.distribution = .fill
        return leftStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leftStack)

        leftStack.addArrangedSubview(imagesStack)
        leftStack.addArrangedSubview(labelsStack)
        
        imagesStack.addArrangedSubview(sustainabilityImage)
        
        labelsStack.addArrangedSubview(foodTitle)
        labelsStack.addArrangedSubview(foodSubTitle)
        
        labelsStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        sustainabilityImage.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        sustainabilityImage.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        imagesStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        leftStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        leftStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true

        leftStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSustainabilityImage(sustainabilityRating: Int) {
        switch sustainabilityRating {
        case 1:
            sustainabilityImage.image = UIImage(systemName: "a.circle.fill")
            sustainabilityImage.tintColor = .systemGreen
            return
        case 2:
            sustainabilityImage.image = UIImage(systemName: "b.circle.fill")
            sustainabilityImage.tintColor = UIColor(hexString: "#61a32f")
            return
        case 3:
            sustainabilityImage.image = UIImage(systemName: "c.circle.fill")
            sustainabilityImage.tintColor = .systemYellow
            return
        case 4:
            sustainabilityImage.image = UIImage(systemName: "d.circle.fill")
            sustainabilityImage.tintColor = .systemOrange
            return
        case 5:
            sustainabilityImage.image = UIImage(systemName: "e.circle.fill")
            sustainabilityImage.tintColor = .systemRed
            return
        default:
            print("DEFAULT")
            sustainabilityImage.tintColor = .systemPurple
            return
        }
    }
    
    func loadTagImages() {
        guard let food = self.food else {
            fatalError("$ERROR: Food is nil")
        }
        
        if (food.tags.contains("vegetarian")) {
            let vegetarianIcon: UIImageView = UIImageView(image: K.vegetarianImage)
            vegetarianIcon.tintColor = .systemGreen
            imagesStack.addArrangedSubview(vegetarianIcon)
            vegetarianIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
            vegetarianIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            print("FOOD IS VEGETARIAN")
        }
        
        if (food.tags.contains("local")) {
            let localIcon: UIImageView = UIImageView(image: K.localImage)
            localIcon.tintColor = .systemYellow
            imagesStack.addArrangedSubview(localIcon)
            localIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
            localIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
//            print("FOOD IS VEGETARIAN")
        }
    }
    
}
