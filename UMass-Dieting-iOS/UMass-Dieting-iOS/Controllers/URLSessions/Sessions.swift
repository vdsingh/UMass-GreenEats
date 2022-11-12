//
//  File.swift
//  UMass-Dieting-iOS
//
//  Created by Aayush Bhagat on 11/12/22.
//

import Foundation

class Sessions{
    static func loadFoodData(diningHall: String, menu: String)  async -> [Food]? {
        
        struct Response: Codable {
            var foods: [Food]
        }
        
        guard let url = URL(string: "\(Constants.API.API_URL)api/foods/get/berkshire/dinner_menu") else {
            print("url not found")
            return nil
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                
                return decodedResponse.foods
            }
        }
        catch{
            print("invvalid data")
        }
        return nil
    }
}
