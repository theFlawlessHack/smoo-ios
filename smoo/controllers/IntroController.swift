//
//  IntroController.swift
//  smoo
//
//  Created by Jessica Joseph on 1/29/18.
//  Copyright © 2018 Jessica Joseph. All rights reserved.
//

import UIKit
import Parse

class IntroController: UIViewController {

    var signupMode = true
    var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupOrLogin(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            createAlert(title: "Error in form", message: "Please enter an email and password")
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signupMode {
                // Sign up
                let user = PFUser()
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    if error != nil {
                        var displayErrorMessage = "PLease try again later."
                        
                        if let errorMessage = error?.localizedDescription as? String {
                            displayErrorMessage = errorMessage
                        }
                        
                        self.createAlert(title: "Sign Up Error", message: displayErrorMessage)
                    } else {
                        print("User signed up")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                })
            } else {
                // Login
                
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        var displayErrorMessage = "PLease try again later."
                        
                        if let errorMessage = error?.localizedDescription as? String {
                            displayErrorMessage = errorMessage
                        }
                        
                        self.createAlert(title: "Login Error", message: displayErrorMessage)
                    } else {
                        print("logged in ")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                })
            }
        }
    }
    
    @IBAction func changeSignupMode(_ sender: Any) {
        if signupMode {
            signupMode = false
            signupOrLoginButton.setTitle("Login", for: [])
            changeSignupModeButton.setTitle("Sign Up", for: [])
            messageLabel.text = "Don't have an account?"
        } else {
            signupMode = true
            signupOrLoginButton.setTitle("Sign Up", for: .normal)
            changeSignupModeButton.setTitle("Login", for: .normal)
            messageLabel.text = "Already have an account?"
        }
    }
    
    @IBOutlet weak var signupOrLoginButton: UIButton!
    @IBOutlet weak var changeSignupModeButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            performSegue(withIdentifier: "showUserTable", sender: self)
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
