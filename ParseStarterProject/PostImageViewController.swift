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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        // image is set in the var above.
        newImage.image = image
    }
    
    @IBAction func postAnImage(sender: AnyObject) {
        // Create a class on the fly, can only be done when importing Parse
        var post = PFObject(className: "Post")
        
    }
    
}
