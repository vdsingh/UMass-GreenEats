//
//  IntialViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Aayush Bhagat on 11/13/22.
//

import UIKit
class InitialViewController: UINavigationController {
    
    var userDefaults = UserDefaults.standard
    
    var launchImageView: UIImageView?
    var nextButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let launchImageView = UIImageView.fromGif(frame: view.frame, resourceName: "LaunchScreenGIF") else { return }
        self.launchImageView = launchImageView
        view.addSubview(launchImageView)
        launchImageView.startAnimating()
        launchImageView.layer.speed = 1
        
        let offset: CGFloat = 100
        nextButton = UIButton(frame: CGRect(x: offset / 2, y: UIScreen.main.bounds.height / 2 + (offset / 2), width: UIScreen.main.bounds.width - offset, height: offset/2))
        
        if let nextButton = self.nextButton {
            nextButton.backgroundColor = UIColor(hexString: K.orangeColorHex)
            nextButton.layer.cornerRadius = 15
            nextButton.setTitle("Let's Eat!", for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.addTarget(self, action: #selector(changeView), for: .touchUpInside)
            view.addSubview(nextButton)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @objc func changeView(){
        if self.userDefaults.string(forKey: K.genderKey) != nil{
            performSegue(withIdentifier: "ToTabController", sender: self)
        } else {
            performSegue(withIdentifier: "ToUserInfoForm", sender: self)
        }
        self.launchImageView?.animationImages = nil
        self.launchImageView?.removeFromSuperview()
        self.nextButton?.removeFromSuperview()
    }
}
