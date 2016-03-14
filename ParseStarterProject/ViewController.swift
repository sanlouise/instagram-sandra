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
    
    @IBOutlet weak var importedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Take a new photo
        
        
        /*
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
    }
*/

}


