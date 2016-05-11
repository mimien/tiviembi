//
//  LoginViewController.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 06/04/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import UIKit
import Stormpath

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadingIndicator.hidden = true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        self.view.endEditing(true)
        loadingIndicator.hidden = false
        loadingIndicator.startAnimating()
        
        Stormpath.sharedSession.login(emailTextField.text!, password: passwordTextField.text!, completionHandler: onSuccess)
    }
//    
//    @IBAction func loginWithFacebook(sender: AnyObject) {
//        Stormpath.sharedSession.login(socialProvider: .Facebook, completionHandler: onSuccess)
//    }
//    
//    @IBAction func loginWithGoogle(sender: AnyObject) {
//        Stormpath.sharedSession.login(socialProvider: .Google, completionHandler: onSuccess)
//    }

    @IBAction func resetPassword(sender: AnyObject) {
        if emailTextField.text! == "" || !(emailTextField.text?.containsString("@"))! {
            self.showAlert(withTitle: "Error", message: "Email not valid")
        }
        Stormpath.sharedSession.resetPassword(emailTextField.text!) { (success, error) -> Void in
            if let error = error {
                self.showAlert(withTitle: "Error", message: error.localizedDescription)
            } else {
                self.showAlert(withTitle: "Success", message: "Password reset email sent!")
            }
        }
    }
    
    func onSuccess(success: Bool, error: NSError?) {
        if let error = error {
            showAlert(withTitle: "Error", message: error.localizedDescription)
        }
        else {
            passwordTextField.text = ""
            performSegueWithIdentifier("login", sender: self)
        }
        loadingIndicator.stopAnimating()
        loadingIndicator.hidden = true
    }
    
    @IBOutlet weak var loginWithGoogle: UIButton!
    
    
}

// Helper extension to display alerts easily.
extension UIViewController {
    func showAlert(withTitle title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}