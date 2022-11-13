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
    
    var mealPlan: MealPlan? = MealPlan(foods: [

    ], calories: 25, saturatedFat: 30, transFat: 35, cholesterol: 40, sodium: 20, total_carbs: 20, dietary_fiber: 30, sugars: 20, protein: 20)
    
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
        self.mealPlan?.foods = []
        foodsTableView.reloadData()
        Sessions.loadFoodData(diningHall: diningHall.key, menu:  mealTypeKeyDictionary[mealType]!) {
            print("Completion called!")
            self.spinner.isHidden = true
            self.mealPlan = MealPlan(foods: State.shared.DiningFoods[diningHall.key]?[self.mealTypeKeyDictionary[mealType]!] ?? [], calories: 0, saturatedFat: 0, transFat: 0, cholesterol: 0, sodium: 0, total_carbs: 0, dietary_fiber: 0, sugars: 0, protein: 0)
            if(self.mealPlan?.foods.count == 0){
                self.errorLabel.isHidden = false
            }
            self.foodsTableView.reloadData()
        }
    }
}

extension MealPlanViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mealPlan = self.mealPlan else {
            fatalError("$ERROR: Meal plan is nil!")
        }
        print("FOOD COUNT: \(mealPlan.foods.count)")
//        tableView.reloadData()
        return mealPlan.foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mealPlan = self.mealPlan else {
            fatalError("$ERROR: Meal plan is nil!")
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.reuseIdentifier, for: indexPath) as? FoodTableViewCell {
            let food: Food = mealPlan.foods[indexPath.row]
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
        self.selectedFood = mealPlan?.foods[indexPath.row]
        performSegue(withIdentifier: "ToFoodViewController", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
