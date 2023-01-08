//
//  Recommendation.swift
//  UMass-Dieting-iOS
//
//  Created by Aayush Bhagat on 11/13/22.
//

import Foundation
struct RecommendationBody: Codable{
    var tag_preferences: [String]
    var recommended_calories: Float
    var dining_hall: String
    var menu: String
}

struct Recommendation: Codable{
    var dishes: [Food]?
    var calories: Float?
    var total_fat: Float?
    var sat_fat: Float?
    var trans_fat: Float?
    var cholestrol: Float?
    var sodium: Float?
    var total_carbs: Float?
    var dietary_fiber: Float?
    var sugar: Float?
    var protein: Float?
    var co2: Float?
}
