//  SignUpViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Aayush Bhagat on 11/12/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        signUpButton.isEnabled = false
        initializeHideKeyboard()
    }
    
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    func validateTextFields() -> Bool{
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return false
        }
        return true
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let userFormViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserInfoVC" ) as? UserInfoFormViewController
        self.view.window?.rootViewController = userFormViewController
        self.view.window?.makeKeyAndVisible()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(validateTextFields()){
            signUpButton.isEnabled = true
        }
    }
}
