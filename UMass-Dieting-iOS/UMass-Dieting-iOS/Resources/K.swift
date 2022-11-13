//
//  K.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import Foundation
import UIKit
class K {
    static let vegetarianImage = UIImage(systemName: "carrot.fill")
    static let localImage = UIImage(systemName: "map.fill")
    static let halalImage = UIImage(systemName: "h.fill")
    static let sustainableImage = UIImage(systemName: "leaf.fill")
    static let wholeGrainImage = UIImage(systemName: "sun.min.fill")
    static let antibioticFreeImage = UIImage(systemName: "allergens.fill")

    
    static let dietaryTagsKey = "diet-tags"
    
    static let vegTag = "con-veg"
    static let halalTag = "con-halal"
    static let localTag = "con-loc"
    static let sustainableTag = "con-sus"
    static let wholeGrainTag = "con-whlgrn"
    static let antibioticFreeTag = "con-antibfr"
    
    static let tagMap: [String: String] = [vegTag: "Vegetarian", halalTag: "Halal", localTag: "Local", sustainableTag: "Sustainable", wholeGrainTag: "Whole Grain", antibioticFreeTag: "Antibiotic Free"]
    
    //User Info Keys:
    static let genderKey = "gender"
    static let weightKey = "weight"
    static let heightKey = "height"
    static let ageKey = "age"
    static let caloriesKey = "calories"
    
    static let goalKey = "goal"
    static let activityLevelKey = "activity-level"
    
    static let orangeColorHex = "FEA42E"
}
