//
//  File.swift
//  UMass-Dieting-iOS
//
//  Created by Aayush Bhagat on 11/12/22.
//

import Foundation

class Sessions {
    
    static var dataTask: URLSessionDataTask?
    
    public static func loadFoodData(diningHall: String, menu: String, completion: @escaping () -> Void){
        
        if((State.shared.DiningFoods[diningHall]?[menu]?.count)! > 0){
            completion()
            return
        }
        
        guard let url = URL(string: "\(Constants.API.API_URL)api/foods/get/\(diningHall)/\(menu)") else {
            print("$ERROR: url not found")
            return
        }
                
        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let decodedData = try JSONDecoder().decode([Food].self, from: data)
                    DispatchQueue.main.async {
                        State.shared.DiningFoods[diningHall]?[menu] = decodedData
                        completion()
                    }
            } catch let jsonError as NSError {
                print("$ERROR: \(jsonError)")
                print(String(describing: jsonError))
                print(jsonError.localizedDescription)
            }
        })
        dataTask?.resume()
    }
    
    public static func loadRecommendation(recommendationBody: RecommendationBody, completion: @escaping () -> Void){

        
        if(State.shared.recommendationFoods[recommendationBody.dining_hall]?[recommendationBody.menu]! != nil){
            print("EEEEE")
            completion()
            return
        }
        
        guard let url = URL(string: "\(Constants.API.API_URL)api/recommendations/create") else {
            print("URL not found")
            completion()
            return
        }
        
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(recommendationBody)
            
            dataTask?.cancel()
            dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, res, error in
                    
                guard let data = data else {
                    return
                }
                
                do{
                    let decodedData = try  JSONDecoder().decode(Recommendation.self, from: data)
                    DispatchQueue.main.async {
                        State.shared.recommendationFoods[recommendationBody.dining_hall]?[recommendationBody.menu] = decodedData
                        completion()
                        print("DATA \(decodedData)")
                    }
                }
                catch let jsonError as NSError{
                    print("$ERROR: \(jsonError)")
                    print(String(describing: jsonError))
                    print(jsonError.localizedDescription)
                }
                
            })
            
            dataTask?.resume()
        }
        catch let jsonError as NSError {
            print("$ERROR: \(jsonError)")
            print(String(describing: jsonError))
            print(jsonError.localizedDescription)
        }
        
    }
}
