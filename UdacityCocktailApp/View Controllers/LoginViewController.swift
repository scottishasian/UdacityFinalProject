//
//  LoginViewController.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 03/12/2018.
//  Copyright © 2018 Kynan Song. All rights reserved.
//

import UIKit
//Need to try and use a different API

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var LoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var offlineLogIn: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserNameTextField.delegate = self
        PasswordTextField.delegate = self
        LoadingIndicator.isHidden = true
        offlineLogIn.isHidden = true
        
        UserNameTextField.text = defaults.string(forKey: "username")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func pressLoginButton(_ sender: Any) {
        let username = UserNameTextField.text
        let password = PasswordTextField.text
        
        if username != "" && password != "" {
            LoadingIndicator.isHidden = false
            self.LoadingIndicator.startAnimating()
            logUserIn(userName: username!, password: password!)
            defaults.set(username, forKey: "username")
            dismissKeyboard()
            print("Can log in")
        } else {
            print("Please type in a username or password")
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func pressSignUp(_ sender: Any) {
        openLink(Constants.Udacity.SignUp)
    }
    
    @IBAction func offlineTestButton(_ sender: Any) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "AppEntranceController") as! UINavigationController
        self.present(controller, animated: true, completion: nil)
    }
    
    private func logUserIn(userName : String, password : String) {
        DataClient.sharedInstance().authenticateUser(username: userName, password: password) {(success, error) in
            if success {
                performUIUpdatesOnMain {
                    self.UserNameTextField.text = ""
                    self.PasswordTextField.text = ""
                    self.unsubscribeToKeyboardNotifications()
                }
                let controller = self.storyboard!.instantiateViewController(withIdentifier: "AppEntranceController") as! UINavigationController
                self.present(controller, animated: true, completion: nil)
            } else {
                performUIUpdatesOnMain {
                    self.showInfo(withTitle: "Login Error", withMessage: error ?? "Error while performing login.")
                    self.LoadingIndicator.isHidden = true
                    print(error ?? Constants.ErrorMessages.loginError)
                }
            }
            performUIUpdatesOnMain {
                self.LoadingIndicator.stopAnimating()
                self.LoadingIndicator.isHidden = true
            }
        }
    }
    
}
