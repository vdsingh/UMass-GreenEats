//
//  UserPreferencesViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Aayush Bhagat on 11/12/22.
//

import UIKit

class UserPreferencesViewController: UIViewController {
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dietRestrictionLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< HEAD
        let recBody = RecommendationBody.init(tag_preferences: [], recommended_calories: 3000, dining_hall: "berkshire", menu: "dinner_menu")
        
        Sessions.loadRecommendation(recommendationBody: recBody)

=======
>>>>>>> b799b49688bc09021bae4e5dda5eeb18f1754901
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        genderLabel.text = "Gender: \(userDefaults.string(forKey: K.genderKey) ?? "")"
        weightLabel.text = "Weight: \(userDefaults.string(forKey: K.weightKey) ?? "")"
        heightLabel.text = "Height: \(userDefaults.string(forKey: K.heightKey) ?? "")"
        ageLabel.text = "Age: \(userDefaults.string(forKey: K.ageKey) ?? "")"
        
        var dietRes = ""
        if let dietTags = userDefaults.array(forKey: K.dietaryTagsKey){
            for tag in dietTags {
                if let readableTag = K.tagMap[tag as! String] {
                    dietRes += readableTag + ", "
                }
            }
        }
        dietRestrictionLabel.text = "Dietary Restrictions: \(dietRes)"
        calorieLabel.text = "Daily Calories: \(userDefaults.string(forKey: K.caloriesKey) ?? "")"
        goalLabel.text = "Goals: \(userDefaults.string(forKey: K.goalKey) ?? "")"
        activityLabel.text = "Activity: \(userDefaults.string(forKey: K.activityLevelKey) ?? "")"
    }
    
    
    @IBAction func changePrefTapped(_ sender: Any) {
        let userFormViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserInfoVC" ) as? UserInfoFormViewController
        self.view.window?.rootViewController = userFormViewController
        self.view.window?.makeKeyAndVisible()
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
