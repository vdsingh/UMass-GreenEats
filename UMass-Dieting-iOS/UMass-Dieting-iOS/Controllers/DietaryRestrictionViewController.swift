//
//  DietaryRestrictionViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import Foundation
import UIKit

class DietaryRestrictionViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var buttonStack: UIStackView!
    
    var isVeg: Bool = false
    var isHalal: Bool = false
    var isLocal: Bool = false
    var isSustainable: Bool = false
    var isWholeGrain: Bool = false
    var isAntibioticFree: Bool = false
        
    override func viewDidLoad() {
        buttonStack.arrangedSubviews.forEach({
            let button = $0 as! UIButton
            button.backgroundColor = .systemBackground
            button.titleLabel?.textColor = .link
            button.layer.borderColor = UIColor.link.cgColor
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
        })
        
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        //Unselected
        if(sender.backgroundColor == .link) {
            sender.backgroundColor = .systemBackground
            sender.titleLabel?.textColor = .link
            sender.layer.borderColor = UIColor.link.cgColor
        } else {
            sender.backgroundColor = .link
//            sender.titleLabel?.textColor = .white
            sender.tintColor = .white
            sender.layer.borderColor = UIColor.link.cgColor
            sender.layer.cornerRadius = 10
            sender.layer.borderWidth = 1
        }
        
        if(sender.titleLabel?.text == "Vegetarian"){
            isVeg = !isVeg
        } else if (sender.titleLabel?.text == "Halal"){
            isHalal = !isHalal
        } else if (sender.titleLabel?.text == "Local-Only"){
            isLocal = !isLocal
        } else if (sender.titleLabel?.text == "Sustainable"){
            isSustainable = !isSustainable
        } else if (sender.titleLabel?.text == "Whole Grain"){
            isWholeGrain = !isWholeGrain
        } else if (sender.titleLabel?.text == "Antibiotic-Free"){
            isAntibioticFree = !isAntibioticFree
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        var dietaryRestrictions: [String] = []

        if(isVeg) {
            dietaryRestrictions.append(K.vegTag)
        }
        if(isHalal) {
            dietaryRestrictions.append(K.halalTag)
        }
        if(isLocal) {
            dietaryRestrictions.append(K.localTag)
        }
        if(isSustainable) {
            dietaryRestrictions.append(K.sustainableTag)
        }
        if(isWholeGrain) {
            dietaryRestrictions.append(K.wholeGrainTag)
        }
        if(isAntibioticFree) {
            dietaryRestrictions.append(K.antibioticFreeTag)
        }
        
        userDefaults.set(dietaryRestrictions, forKey: K.dietaryTagsKey)
    }
}
