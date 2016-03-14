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
    
    @IBAction func signUp(sender: UIButton) {
        
        // Error message if details are incorrect.
        if username.text == "" || passwordField.text == "" {
            //Create alert.
            var alert = UIAlertController(title: "Oops!", message: "Please enter a valid username and password!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction((UIAlertAction(title: "Got it!", style: .Default, handler: { (action) -> Void in
                //Get rid of the alert.
                self.dismissViewControllerAnimated(true, completion: nil)
            })))
            //Display the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func logIn(sender: UIButton) {
    }
      //Add activity indicators for spinners and alerts.
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }


}


