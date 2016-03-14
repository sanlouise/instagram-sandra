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


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var importedImage: UIImageView!
    
    //Add activity indicators for spinners and alerts.
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // Called as soon as an image has been chosen.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        //Gets rid of UIImagePickerController
        self.dismissViewControllerAnimated(true, completion: nil)
        importedImage.image = image
    }
    
    
    @IBAction func createAlert(sender: AnyObject) {
        // Setting up the alert message.
        let alert = UIAlertController(title: "Hello!", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)

    }
    
    @IBAction func pauseApp(sender: AnyObject) {
        
        //Make a spinner.
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        //Set it in the center of the screen.
        activityIndicator.center = self.view.center
        //Disappear when pause is stopped.
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        // Add it to the view.
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        // Ensure that the user can't do anything while the spinner is active.
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    @IBAction func restoreApp(sender: AnyObject) {
        // Ensure the spinner stops.
        activityIndicator.stopAnimating()
        // Reactivate the app.
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }

    @IBAction func imageImporter(sender: UIButton) {
        //Manages the process of picking an image
        let image = UIImagePickerController()
        // Set delegate to VC.
        image.delegate = self
        // Just change PhotoLibrary to Camera to take photos.
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        // Disallows users to edit their photo prior to importing.
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Take a new photo
        
        
        /*

        let product = PFObject(className: "Products")
        product["name"] = "Pizza"
        product["description"] = "Vegetarian!"
        product["price"] = 9.50
        product.saveInBackgroundWithBlock { (success, error) -> Void in
            if success == true {
                print("Object saved with ID \(product.objectId!)")
            } else {
                print("Failed!")
                print(error)
            }
        }
        
        // To retrieve data from the database
        var query = PFQuery(className: "Products")
        query.getObjectInBackgroundWithId("KGXfBJSsLF", block: { (object: PFObject?, error ) -> Void in
            if error != nil {
                print(error)
            } else if let product = object {
                product["description"] = "Super Vegan"
                product["price"] = 5.99
                product.saveInBackground()
                print(object!.objectForKey("description"))
            }
        })

*/
    }


}


