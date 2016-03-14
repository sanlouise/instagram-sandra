/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse


class ViewController: UIViewController {
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var signInUp: UIButton!
    @IBOutlet weak var switchSignInUp: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    //Add activity indicators for spinners and alerts.
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    // To switch between sign up/ sign in view.
    var signupActive = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Make keyboard disappear when user clicks outside of text field.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    func displayAlert(title: String, message: String) {
        //Create alert.
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "Got it!", style: .Default, handler: { (action) -> Void in
            //Get rid of the alert.
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        //Display the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func signUp(sender: UIButton) {
        
        // Error message if details are incorrect.
        if username.text == "" || passwordField.text == "" {
            displayAlert("Error in form", message: "Please enter a username and password")
        } else {
            //Create spinner
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            //Position it.
            activityIndicator.center = self.view.center
            //Hide when stopped.
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            //activate activityIndicator
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var errorMessage = "Oops, something went wrong. Please try again later."

            if signupActive == true {
            //Sign Up Code.
            //Create the user.
            let user = PFUser()
            user.username = username.text
            user.password = passwordField.text
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                // Eitherway, stop animation.
                self.activityIndicator.stopAnimating()
                // Make app interactive again.
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                if error == nil {
                    // Signup successful.
                } else {
                    // Signup unsuccessful.
                    //Unwrap and cast the error into a string.
                    if let errorString = error!.userInfo["error"] as? String {
                        errorMessage = errorString
                    }
                    self.displayAlert("Signup Failed", message: errorMessage)
                }
            })
            } else {
                
                PFUser.logInWithUsernameInBackground(username.text!, password: passwordField.text!, block: { (user, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    if user != nil {
                        // Logged In!
                    } else {
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayAlert("Failed Login", message: errorMessage)
                    }
                })
            }
        }
    }
    @IBAction func logIn(sender: UIButton) {
        //In case user sees signup mode.
        if signupActive == true {
            //Then switch to login mode.
            pageTitle.text = "Log In"
            signInUp.setTitle("Log In", forState: UIControlState.Normal)
            switchSignInUp.setTitle("Sign Up", forState: UIControlState.Normal)
            switchLabel.text = "Or sign up."
            // Switch to login mode.
            signupActive = false
        } else {
        //In case user sees login mode.
        if signupActive == false {
            pageTitle.text = "Sign Up"
            signInUp.setTitle("Sign Up", forState: UIControlState.Normal)
            switchSignInUp.setTitle("Log In", forState: UIControlState.Normal)
            switchLabel.text = "Already have an account?"
            // Switch to signup mode.
            signupActive = true
            
        }
        
    }

}

}
