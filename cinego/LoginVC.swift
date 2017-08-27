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
    var orderRepository: IOrderRepository!
    
    weak var delegate: LoginVCDelegate?
    var goToAccountPage = true
    var user: User?
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let loggedInUser = userRepository.getCurrentUser() {
            performSegue(withIdentifier: "openAccountPageAfterLoggingIn", sender: loggedInUser)
        }
    }
    
    @IBAction func loginButtonDidTapped(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let userRepo = userRepository as! UserRepository
        let loggedInUser = userRepo.login(username: username, password: password)
        
        if loggedInUser != nil {
            
            if goToAccountPage {
                user = loggedInUser
                performSegue(withIdentifier: "openAccountPageAfterLoggingIn", sender: loggedInUser)
            } else {
                delegate?.didLoggedIn(loggedInUser!)
                dismiss(animated: true, completion: nil)
            }
            
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
        
        else if segue.identifier == "openAccountPageAfterLoggingIn" {
            let currentUser = sender as! User
            let accountTableVC = segue.destination as! AccountTableVC
            let orders = orderRepository.findAll(byUser: currentUser)
            let pastOrders = orders.filter{ $0.movieSession.startTime <= Date() }
            let upcomingOrders = orders.filter { $0.movieSession.startTime > Date()  }
            accountTableVC.user = currentUser
            accountTableVC.pastOrders = pastOrders
            accountTableVC.upcomingBookings = upcomingOrders
            accountTableVC.orderRepository = orderRepository
        }
    }

}

extension LoginVC : RegisterVCDelegate {
    func userDidRegister(_ user: User) {
        if let loggedInUser = (userRepository as! UserRepository).login(username: user.username, password: user.password) {
            delegate?.didLoggedIn(loggedInUser)
            dismiss(animated: true, completion: nil)
        }
        
    }
}
