//
//  UserInfoFormViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//


import Foundation
import UIKit

class UserInfoFormViewController: UIViewController {
    
    @IBOutlet weak var bodyweightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var genderPopUpButton: UIButton!
    @IBOutlet weak var activityLevelPopUpButton: UIButton!
    @IBOutlet weak var dietGoalPopUpButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!

    private var gender: String = "Select a Gender"
    private var activityLevel: String = "Select an Activity Level"
    private var goal: String = "Select your Goal"
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePopUpButtons()
        nextButton.isEnabled = false
        
        ageTextField.delegate = self
        bodyweightTextField.delegate = self
        heightTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func configurePopUpButtons() {
        let genderSelectionClosure = { (action: UIAction) in
            self.userDefaults.set(action.title, forKey: K.genderKey)
            self.gender = action.title
            self.renderNextButton()
        }
        genderPopUpButton.menu = UIMenu(children: [
            UIAction(title: "Select a Gender", state: .on, handler: genderSelectionClosure),
            UIAction(title: "Male", handler: genderSelectionClosure),
            UIAction(title: "Female", handler: genderSelectionClosure)
        ])
        
        genderPopUpButton.showsMenuAsPrimaryAction = true
        genderPopUpButton.changesSelectionAsPrimaryAction = true
        
        
        let activitySelectionClosure = { (action: UIAction) in
            self.activityLevel = action.title
            self.userDefaults.set(action.title, forKey: K.activityLevelKey)
            self.renderNextButton()
        }
        activityLevelPopUpButton.menu = UIMenu(children: [
            UIAction(title: "Select an Activity Level", state: .on, handler: activitySelectionClosure),
            UIAction(title: "Not Active", handler: activitySelectionClosure),
            UIAction(title: "Somewhat Active", handler: activitySelectionClosure),
            UIAction(title: "Moderately Active", handler: activitySelectionClosure),
            UIAction(title: "Very Active", handler: activitySelectionClosure)
        ])
        
        activityLevelPopUpButton.showsMenuAsPrimaryAction = true
        activityLevelPopUpButton.changesSelectionAsPrimaryAction = true
        
        let goalSelectionClosure = { (action: UIAction) in
            self.userDefaults.set(action.title, forKey: K.goalKey)
            self.goal = action.title
            self.renderNextButton()
        }
        dietGoalPopUpButton.menu = UIMenu(children: [
            UIAction(title: "Select your Goal", state: .on, handler: goalSelectionClosure),
            UIAction(title: "Lose Weight", handler: goalSelectionClosure),
            UIAction(title: "Maintain Weight", handler: goalSelectionClosure),
            UIAction(title: "Gain Weight", handler: goalSelectionClosure),
        ])
        
        dietGoalPopUpButton.showsMenuAsPrimaryAction = true
        dietGoalPopUpButton.changesSelectionAsPrimaryAction = true
    }
    
    private func renderNextButton() {
        if(gender != "Select a Gender" &&
           activityLevel != "Select an Activity Level" &&
           goal != "Select your Goal" &&
           verifyNumberFields()
        ) {
            userDefaults.set(calculateCalories(), forKey: K.caloriesKey)
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    private func verifyNumberFields() -> Bool {
        if let ageText = ageTextField.text, let heightText = heightTextField.text, let bodyweightText = bodyweightTextField.text {
            userDefaults.set(heightText, forKey: K.heightKey)
            userDefaults.set(ageText, forKey: K.ageKey)
            userDefaults.set(bodyweightText, forKey: K.weightKey)

            return ageText.isNumber && heightText.isNumber && bodyweightText.isNumber
        } else {
            fatalError("$ERROR: Textfield texts are nil.")
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    For men: BMR = 66.5 + (13.75 * weight in kg) + (5.003 * height in cm) - (6.75 * age)
//
//    For women: BMR = 655.1 + (9.563 * weight in kg) + (1.850 * height in cm) - (4.676 * age)
    
    private func calculateCalories() -> Float {
        if(!verifyNumberFields()) {
            return -1
        }
        let weightKG = (bodyweightTextField.text!.floatValue) * (1/2.20462)
        let heightCM = Float(heightTextField.text!.floatValue) * (1/0.393701)
        let ageYears = Float(ageTextField.text!.floatValue)
        var BMR: Float = 0
        if(gender == "male") {
            BMR = 66.5 + (13.75 * weightKG) + (5.003 * heightCM) - (6.75 * ageYears)
        } else {
            BMR = 655.1 + (9.563 * weightKG) + (1.850 * heightCM) - (4.676 * ageYears)
        }

        switch activityLevel {
        case "Not Active":
            return BMR * 1.2
        case "Somewhat Active":
            return BMR * 1.375
        case "Moderately Active":
            return BMR * 1.55
        case "Very Active":
            return BMR * 1.725
        default:
            print("$ERROR: Activity level not selected")
            return 2000
        }
    }
}

extension UserInfoFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        renderNextButton()
    }
}
