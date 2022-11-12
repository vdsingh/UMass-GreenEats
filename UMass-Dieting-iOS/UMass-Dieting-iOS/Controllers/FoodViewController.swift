//
//  FoodViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import Foundation
import UIKit
class FoodViewController: UIViewController {
    var food: Food? = nil
//        didSet {
//            updateNutritionLabel()
//        }
//    }
//
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var servingSizeLabel: UILabel!
    
    
    @IBOutlet weak var nutritionLabelView: UIView!
    @IBOutlet weak var caloriesNumberLabel: UILabel!
    @IBOutlet weak var fatCalLabel: UILabel!
    @IBOutlet weak var totalFatNumberLabel: UILabel!
    @IBOutlet weak var saturatedFatNumberLabel: UILabel!
    @IBOutlet weak var transFatNumberLabel: UILabel!
    @IBOutlet weak var cholesterolNumberLabel: UILabel!
    @IBOutlet weak var sodiumNumberLabel: UILabel!
    @IBOutlet weak var carbohydratesNumberLabel: UILabel!
    @IBOutlet weak var dietaryFiberNumberLabel: UILabel!
    @IBOutlet weak var sugarNumberLabel: UILabel!
    @IBOutlet weak var proteinNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nutritionLabelView.layer.borderWidth = 3
        nutritionLabelView.layer.borderColor = UIColor.black.cgColor
        updateNutritionLabel()
    }
    
    func updateNutritionLabel() {
        guard let food = self.food else {
            fatalError("$ERROR: Food is nil.")
        }
        
        foodNameLabel.text = "\(food.name)"
        
        servingSizeLabel.text = "\(food.servingSize)"
        caloriesNumberLabel.text = "\(food.calories)"
        fatCalLabel.text = "\(food.fatCal)"
        totalFatNumberLabel.text = "\(food.totalFat)"
        saturatedFatNumberLabel.text = "\(food.saturatedFat)"
        transFatNumberLabel.text = "\(food.transFat)"
        cholesterolNumberLabel.text = "\(food.cholesterol)"
        sodiumNumberLabel.text = "\(food.sodium)"
        carbohydratesNumberLabel.text = "\(food.totalCarbs)"
        dietaryFiberNumberLabel.text = "\(food.dietaryFiber)"
        sugarNumberLabel.text = "\(food.sugars)"
        proteinNumberLabel.text = "\(food.protein)"
    }
    
    
}
