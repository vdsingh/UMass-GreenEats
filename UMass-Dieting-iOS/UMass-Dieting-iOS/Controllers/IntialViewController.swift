//
//  IntialViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Aayush Bhagat on 11/13/22.
//

import UIKit

class IntialViewController: UINavigationController {
    
    var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        changeView()
        
        return
    }
    
    func changeView(){
        if self.userDefaults.string(forKey: K.genderKey) != nil{
//              performSegue(withIdentifier: "TabBarSegue", sender: self )
            let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC" ) as? UITabBarController
            self.view.window?.rootViewController = tabViewController!
            self.view.window?.makeKeyAndVisible()
        }
        else{
            let userFormViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserInfoVC" ) as? UserInfoFormViewController
            self.view.window?.rootViewController = userFormViewController
            self.view.window?.makeKeyAndVisible()
//            performSegue(withIdentifier: "UserInfoSegue", sender: self)
        }
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
