//
//  Food.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import Foundation
struct Food: Codable {
    var dish_name: String?
    var servingString: String?

    var serving_size: String?
    var calories: Float?
    var fatCal: Float?
    var total_fat: Float?
    var sat_fat: Float?
    var trans_fat: String?
    var cholesterol: Float?
    var sodium: Float?
    var total_carbs: Float?
    var dietary_fiber: Float?
    var sugar: Float?
    var protein: Float?

    var healthfulness: String?
    var carbon_rating: String?
    
    var ingredients: String?
    var allergens: String?
    
    var tags: String?
}
