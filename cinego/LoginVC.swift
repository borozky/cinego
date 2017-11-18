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
    
    var authViewModel: AuthViewModel! {
        didSet { self.authViewModel.delegate = self }
    }
    
    weak var delegate: LoginVCDelegate?
    
    var goToAccountPage = true
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var cancelLoginButton: UIBarButtonItem!
    
    // Go back to CHECKOUT PAGE on cancel
    @IBAction func cancelLoginDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if delegate == nil {
            self.navigationItem.setRightBarButton(nil, animated: false)
        }
        
        authViewModel.checkAuth()
    }
    
    @IBAction func loginButtonDidTapped(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        authViewModel.login(email, password)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openRegisterVCFromLoginVC" {
            let registerVC = segue.destination as! RegisterVC
            registerVC.delegate = self
        }
        else if segue.identifier == "openAccountPageAfterLoggingIn" {
            let accountTableVC = segue.destination as! AccountTableVC
            let user = sender as! User
            accountTableVC.viewModel.user = user
            accountTableVC.delegate = self
        }
    }
}

extension LoginVC : RegisterVCDelegate {
    func userDidRegister(_ user: User) {
        userLoggedIn(user)
    }
}


extension LoginVC : AccountTableVCDelegate {
    
    // Automatically clear login text
    func didLogout() {
        if emailTextField != nil {
            emailTextField.text = ""
            emailTextField.becomeFirstResponder()
        }
        if passwordTextField != nil {
            passwordTextField.text = ""
        }
    }
}

extension LoginVC: AuthViewModelDelegate {
    func userLoggedIn(_ user: User) -> Void {
        if let delegate = delegate {
            delegate.didLoggedIn(user)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func loginError(_ message: String) -> Void {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func userRegistered(_ user: User) -> Void {
        // nothing here
    }
    func userLoggedOut() -> Void {
        // nothing here
    }
    func registrationError(_ message: String) -> Void {
        // nothing here
    }
    func logoutError(_ message: String) -> Void {
        // nothing here
    }
}
