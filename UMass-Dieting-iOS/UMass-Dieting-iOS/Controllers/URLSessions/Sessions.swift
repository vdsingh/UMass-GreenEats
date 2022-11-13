//
//  File.swift
//  UMass-Dieting-iOS
//
//  Created by Aayush Bhagat on 11/12/22.
//

import Foundation

class Sessions {
    
    static func loadFoodData(diningHall: String, menu: String)  async -> [Food]? {
        print("$LOG: LOAD FOOD DATA CALLED.")
        struct Response: Codable {
            var foods: [Food]
        }
        let url = URL(string: "\(Constants.API.API_URL)api/foods/get/berkshire/dinner_menu")
        let req = URLRequest(url: url!)
        URLSession.shared.dataTask(with: req) { data, response, error in
            
            if let error = error {
                print("$ERROR: \(error.localizedDescription)")
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                let JSONString = """
                  [
                  {
                  "dish_name": "String",
                  "serving_size":"String",
                  "calories":1,
                  "fat_cal":1,
                  "total_fat":1,
                  "sat_fat":1,
                  "trans_fat":1,
                  "cholesterol":1,
                  "sodium":1,
                  "total_carbs":1,
                  "dietary_fiber":1,
                  "sugar":1,
                  "protein":1,
                  "healthfulness":"String",
                  "carbon_rating":"String",
                  "ingredients":"String",
                  "allergens":"String",
                  "tags":"String"
                  }
                  ]
                  """
                
                let jsonData = JSONString.data(using: .utf8)!
                let str = String(decoding: data, as: UTF8.self)
                print("$LOG: GOT DATA! \(data). STR: \(str)")
                
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode([Food].self, from: data)
//                        print("$LOG: OT DATA: \(response). STRING:")
                        
                        //                        print("$RESPONSE: \(response)")
                    } catch let error as NSError{
                        print(String(describing: error))
                        fatalError("\n\n$ERROR: \(error.localizedDescription)\n\n")
                    }
                }
            }
            
        }.resume()
        return nil
    }
}
//    else {
//            fatalError("$ERROR: SOMETHING WRONG WITH URL COMPONENTS")
//        }
