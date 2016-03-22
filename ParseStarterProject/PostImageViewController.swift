//
//  PostImageViewController.swift
//  Sandra-Instagram
//
//  Created by Sandra Adams-Hallie on Mar/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var imageTextField: UITextView!
    @IBAction func pickAnImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        // image is set in the var above.
        newImage.image = image
    }
    
    
    @IBAction func postAnImage(sender: AnyObject) {
        
        //Position it.
        activityIndicator.center = self.view.center
        //Hide when stopped.
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        //activate activityIndicator
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        // We'll need access to the image, message and user ID associated with the object.
        // Create a class on the fly, can only be done when importing Parse
        var post = PFObject(className: "Post")
        post["message"] = imageTextField.text
        post ["userID"] = PFUser.currentUser()!.objectId!
        let imageData = UIImageJPEGRepresentation(newImage.image!, 9.9)
        let imageFile = PFFile(name: "image.png", data: imageData!)
        post ["imageFile"] = imageFile
        post.saveInBackgroundWithBlock{(success, error) -> Void in
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            if error == nil {
                self.displayAlert("Yay!", message: "Your photo was posted successfully.")
                self.newImage.image = UIImage(named: "addphoto")
                self.imageTextField.text = ""
                
            } else {
               self.displayAlert("Oops!", message: "Something went wrong.")
                
            }

        }
    }
    
    // Make keyboard disappear when user clicks outside of text field.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Make keyboard disappear when user clicks on return.
    func textFieldShouldReturn(imageTextField: UITextView) -> Bool {
        imageTextField.resignFirstResponder()
        return true
    }
    
}
