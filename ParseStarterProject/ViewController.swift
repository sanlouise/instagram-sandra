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
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    //Add activity indicators for spinners and alerts.
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    @IBAction func signUp(sender: UIButton) {
        
        // Error message if details are incorrect.
        if username.text == "" || passwordField.text == "" {
            //Create alert.
            let alert = UIAlertController(title: "Oops!", message: "Please enter a valid username and password.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction((UIAlertAction(title: "Got it!", style: .Default, handler: { (action) -> Void in
                //Get rid of the alert.
                self.dismissViewControllerAnimated(true, completion: nil)
            })))
            //Display the alert
            self.presentViewController(alert, animated: true, completion: nil)
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
        }
        
    }
    @IBAction func logIn(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Make keyboard disappear when user clicks outside of text field.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


}


