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
        DiningHall(name: "Worcester Commons", key: "worcester", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 11:59 PM"),
        DiningHall(name: "Berkshire Commons", key: "berkshire", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 11:59 PM"),
        DiningHall(name: "Hampshire Commons", key: "hampshire", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 11:59 PM"),
        DiningHall(name: "Franklin Commons", key: "franklin", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 11:59 PM")
        
    ]
    
    var DiningFoods: [String: [String:[Food]]] = [
        "berkshire": ["breakfast_menu": [], "lunch_menu": [], "dinner_menu": [], "latenight_menu": []],
        "franklin": ["breakfast_menu": [], "lunch_menu": [], "dinner_menu": [], "latenight_menu": []],
        "worcester": ["breakfast_menu": [], "lunch_menu": [], "dinner_menu": [], "latenight_menu": []],
        "hampshire": ["breakfast_menu": [], "lunch_menu": [], "dinner_menu": [], "latenight_menu": []]
    ]
}
