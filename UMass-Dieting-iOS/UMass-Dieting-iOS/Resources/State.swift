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
        DiningHall(name: "Worcester Commons", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 11:59 PM"),
        DiningHall(name: "Berkshire Commons", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 11:59 PM"),
        DiningHall(name: "Hampshire Commons", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 11:59 PM"),
        DiningHall(name: "Franklin Commons", daysOfOperation: "Monday - Sunday", hoursOfOperation: "7:00 AM - 11:59 PM")

    ]
}
