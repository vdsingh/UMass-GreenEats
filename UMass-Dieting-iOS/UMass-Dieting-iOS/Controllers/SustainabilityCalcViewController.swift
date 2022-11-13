//
//  SustainabilityCalcViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Aayush Bhagat on 11/13/22.
//

import UIKit

class SustainabilityCalcViewController: UIViewController {

    @IBOutlet weak var userCarbonLabel: UILabel!
    @IBOutlet weak var carbonDiffLabel: UILabel!
    
    var carbonNum: Float = 0
    
    let averageCarbon: Float = 1822.83
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userCarbonLabel.text = "\(self.carbonNum)"
        carbonDiffLabel.text = "\(averageCarbon - self.carbonNum)"
        // Do any additional setup after loading the view.
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
