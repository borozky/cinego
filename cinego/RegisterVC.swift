//
//  RegisterVC.swift
//  cinego
//
//  Created by Joshua Orozco on 8/24/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

protocol RegisterVCDelegate: class {
    func userDidRegister(_ user: User)
}

class RegisterVC: UIViewController {
    
    var userRepository: IUserRepository!
    weak var delegate: RegisterVCDelegate!
    
    
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var validationErrorsLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        validationErrorsLabel.text = ""
    }
    @IBAction func registerButtonDidTapped(_ sender: Any) {
        let fullname = fullnameTextField.text ?? ""
        let username = usernameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let passwordConfimation = passwordConfirmationTextField.text ?? ""
        
        if fullname == "" {
            validationErrorsLabel.text = "Full name is required"
            return
        }
        
        if username == "" {
            validationErrorsLabel.text = "Username is required"
            return
        }
        
        if email == "" {
            validationErrorsLabel.text = "Email is required"
            return
        }
        
        if password == "" {
            validationErrorsLabel.text = "Password is required"
            return
        }
        
        if passwordConfimation == "" {
            validationErrorsLabel.text = "Password confirmation is required"
            return
        }
        
        guard passwordConfimation == password else {
            validationErrorsLabel.text = "Passwords do not match"
            return
        }
        
        let registeredUser = register(fullname: fullname, username: username, email: email, password: password, passwordConfirmation: passwordConfimation)
        
        guard registeredUser != nil else {
            validationErrorsLabel.text = "Sorry, something went wrong"
            return
        }
        
        delegate.userDidRegister(registeredUser!)
        
    }
    
    private func register(fullname: String, username: String, email: String, password: String, passwordConfirmation: String ) -> User? {
        
        let user = User(id: nil, username: username, email: email, fullname: fullname, password: password, orders: [])
        
        return userRepository.create(user: user)
    }
    
    

}
