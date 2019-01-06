//
//  Login+Extensions.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {
    
    ////////////////////Keyboard Behaviour////////////////////////////
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if UserNameTextField.isFirstResponder || PasswordTextField.isFirstResponder {
            view.frame.origin.y = -getKeyBoardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if UserNameTextField.isFirstResponder || PasswordTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    //Checks if bottom text field is furst responder. If so it will shift the view based on keyboard size.
    
    func getKeyBoardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        //Of a CGRectangle
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
}
