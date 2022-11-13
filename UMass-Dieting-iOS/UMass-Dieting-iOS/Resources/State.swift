//
//  State.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import Foundation
class State {
    static let shared = State()
    
    var diningHalls: [DiningHall] = [
        DiningHall(name: "Worcester Commons", key: "worcester", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 12:00 AM", colorHex: K.orangeColorHex),
        DiningHall(name: "Berkshire Commons", key: "berkshire", daysOfOperation: "Monday - Sunday", hoursOfOperation: "11:00 AM - 12:00 AM", colorHex: K.orangeColorHex),
        DiningHall(name: "Hampshire Commons", key: "hampshire", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 9:00 PM", colorHex: K.orangeColorHex),
        DiningHall(name: "Franklin Commons", key: "franklin", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 9:00 PM", colorHex: K.orangeColorHex)
        
    ]
    
    var DiningFoods: [String: [String:[Food]]] = [
        "berkshire": ["breakfast_menu": [], "lunch_menu": [], "dinner_menu": [], "latenight_menu": []],
        "franklin": ["breakfast_menu": [], "lunch_menu": [], "dinner_menu": [], "latenight_menu": []],
        "worcester": ["breakfast_menu": [], "lunch_menu": [], "dinner_menu": [], "latenight_menu": []],
        "hampshire": ["breakfast_menu": [], "lunch_menu": [], "dinner_menu": [], "latenight_menu": []]
    ]
    
    var recommendationFoods: [String: [String: Recommendation?]] = [
        "berkshire": ["breakfast_menu": nil , "lunch_menu": nil, "dinner_menu": nil, "latenight_menu": nil],
        "franklin": ["breakfast_menu": nil, "lunch_menu": nil, "dinner_menu": nil, "latenight_menu": nil],
        "worcester": ["breakfast_menu": nil, "lunch_menu": nil, "dinner_menu": nil, "latenight_menu": nil],
        "hampshire": ["breakfast_menu": nil, "lunch_menu": nil, "dinner_menu": nil, "latenight_menu": nil]
    ]
}
