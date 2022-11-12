//
//  Food.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import Foundation
struct Food: Codable {
    let name: String
    let servingString: String
    
    let calories: Float32
    let saturatedFat: Float32
    let transFat: Float32
    let cholesterol: Float32
    let sodium: Float32
    let totalCarbs: Float32
    let dietaryFiber: Float32
    let sugars: Float32
    let protein: Float32
    
    let carbonFootprint: Int
    
    let tags: [String]
}
