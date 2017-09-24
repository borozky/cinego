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
        
        if delegate == nil {
            self.navigationItem.setRightBarButton(nil, animated: false)
        }
        
        authViewModel.checkAuth()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        authViewModel.checkAuth()
    }
    
    @IBAction func loginButtonDidTapped(_ sender: Any) {
        let email = usernameTextField.text!
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
        if let loggedInUser = self.authViewModel.currentUser {
            delegate?.didLoggedIn(loggedInUser)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension LoginVC : AccountTableVCDelegate {
    func didLogout() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        usernameTextField.becomeFirstResponder()
    }
}

extension LoginVC: AuthViewModelDelegate {
    func userLoggedIn(_ user: User) -> Void {
        if goToAccountPage {
            performSegue(withIdentifier: "openAccountPageAfterLoggingIn", sender: authViewModel.currentUser)
        } else {
            delegate?.didLoggedIn(user)
            dismiss(animated: true, completion: nil)
        }
    }
    func loginError(_ message: String) -> Void {
        validationErrorsLabel.text = message
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
