//
//  LoginVC.swift
//  cinego
//
//  Created by Joshua Orozco on 8/24/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

protocol LoginVCDelegate: class {
    func didLoggedIn(_ user: User) -> Void
}

class LoginVC: UIViewController {
    
    var userRepository: IUserRepository!
    weak var delegate: LoginVCDelegate!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var validationErrorsLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var cancelLoginButton: UIBarButtonItem!
    @IBAction func cancelLoginDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validationErrorsLabel.text = ""
        validationErrorsLabel.isEnabled = false
    }
    
    @IBAction func loginButtonDidTapped(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let userRepo = userRepository as! UserRepository
        let loggedInUser = userRepo.login(username: username, password: password)
        
        if loggedInUser != nil {
            delegate!.didLoggedIn(loggedInUser!)
            dismiss(animated: true, completion: nil)
        } else {
            validationErrorsLabel.text = "Invalid username/password"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openRegisterVCFromLoginVC" {
            let registerVC = segue.destination as! RegisterVC
            registerVC.delegate = self
            registerVC.userRepository = userRepository
        }
    }

}

extension LoginVC : RegisterVCDelegate {
    func userDidRegister(_ user: User) {
        if let loggedInUser = (userRepository as! UserRepository).login(username: user.username, password: user.password) {
            delegate.didLoggedIn(loggedInUser)
            dismiss(animated: true, completion: nil)
        }
        
    }
}
