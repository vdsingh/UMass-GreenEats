//
//  MealPlanViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import Foundation
import UIKit
class MealPlanViewController: UIViewController {
    
    var selectedFood: Food? = nil
    
    var foods: [[Food]] = [[], []]
    let headers: [String] = ["Recommended Foods", "All Foods"]
    
    var diningHall: DiningHall!
    
    @IBOutlet weak var foodsTableView: UITableView!
    @IBOutlet weak var mealTimesStack: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var mealTypeKeyDictionary:[String: String] = ["Lunch": "lunch_menu", "Break-fast": "breakfast_menu", "Dinner": "dinner_menu", "Late Night": "latenight_menu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodsTableView.delegate = self
        foodsTableView.dataSource = self
        foodsTableView.register(FoodTableViewCell.self, forCellReuseIdentifier: FoodTableViewCell.reuseIdentifier)
        
        guard let diningHall = self.diningHall else {
            fatalError("$ERROR: Dining hall is nil")
        }
        self.title = diningHall.name
        selectMealType(mealType: "Break-fast", diningHall: diningHall)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        mealTimesStack.
        selectMealType(mealType: "Break-fast", diningHall: diningHall)
    }
    
    @IBAction func newTimeClicked(_ sender: UIButton) {
        selectMealType(mealType: sender.titleLabel?.text ?? "", diningHall: self.diningHall)
    }
    
    func selectMealType(mealType: String, diningHall: DiningHall) {
        mealTimesStack.arrangedSubviews.forEach({
            let button = $0 as! UIButton
            if(button.titleLabel?.text == mealType) {
                button.layer.cornerRadius = 10
                button.backgroundColor = .link
                button.tintColor = .white
            } else {
                button.backgroundColor = .systemBackground
                button.tintColor = .link
                button.layer.borderColor = UIColor.link.cgColor
                button.layer.cornerRadius = 10
                button.layer.borderWidth = 1
            }
        })
        
        spinner.isHidden = false
        errorLabel.isHidden = true
        self.foods = [[],[]]
        foodsTableView.reloadData()
        Sessions.loadFoodData(diningHall: diningHall.key, menu:  mealTypeKeyDictionary[mealType]!) {
            print("Completion called!")
            self.foods[1] = State.shared.DiningFoods[diningHall.key]?[self.mealTypeKeyDictionary[mealType]!] ?? []
            
            let body = RecommendationBody(
                tag_preferences: UserDefaults.standard.value(forKey: K.dietaryTagsKey) as! [String],
                recommended_calories: UserDefaults.standard.value(forKey: K.caloriesKey) as! Float,
                dining_hall: diningHall.key,
                menu: self.mealTypeKeyDictionary[mealType]!)
            Sessions.loadRecommendation(recommendationBody: body) {
                    if let recommendation = State.shared.recommendationFoods[diningHall.key]![self.mealTypeKeyDictionary[mealType]!] as? Recommendation {
                        self.foods[0] = recommendation.dishes ?? []
                    }
                    self.spinner.isHidden = true
                    if(self.foods[0].count == 0 && self.foods[1].count == 0){
                        self.errorLabel.isHidden = false
                    }
                    self.foodsTableView.reloadData()
                }
        }
    }
}

extension MealPlanViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(foods[0].count == 0 && foods[1].count == 0) {
            return ""
        }
        return headers[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.reuseIdentifier, for: indexPath) as? FoodTableViewCell {
            let food: Food = foods[indexPath.section][indexPath.row]
            cell.food = food
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
           fatalError("$ERROR: Failed to dequeue food cell!")
        }
    }
}

extension MealPlanViewController: UITableViewDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FoodViewController {
            guard let food = selectedFood else {
                fatalError("$ERROR: Food is nil.")
            }
            destination.food = food
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedFood = foods[indexPath.section][indexPath.row]
        performSegue(withIdentifier: "ToFoodViewController", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
