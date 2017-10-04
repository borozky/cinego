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
    
    weak var delegate: RegisterVCDelegate!
    var authViewModel: AuthViewModel!
    
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerDidTapped(_ sender: Any) {
        let fullname = fullnameTextField.text ?? ""
        let username = usernameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let passwordConfimation = passwordConfirmationTextField.text ?? ""
        
        authViewModel.register(
            email: email,
            password: password,
            passwordConfirmation: passwordConfimation,
            username: username,
            fullname: fullname
        )
    }
    
}

extension RegisterVC: AuthViewModelDelegate {
    func userRegistered(_ user: User) -> Void {
        delegate.userDidRegister(user)
    }
    
    func registrationError(_ message: String) -> Void {
        let alertController = UIAlertController(title: "Registration Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func userLoggedIn(_ user: User) -> Void {
        // nothing here
    }
    func loginError(_ message: String) -> Void {
        // nothing here
    }
    func userLoggedOut() -> Void {
        // nothing here
    }
    func logoutError(_ message: String) -> Void {
        // nothing here
    }
}
