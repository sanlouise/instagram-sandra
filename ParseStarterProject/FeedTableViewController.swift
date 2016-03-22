//
//  FeedTableViewController.swift
//  Sandra-Instagram
//
//  Created by Sandra Adams-Hallie on Mar/22/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    
    var users = [String: String]()
    var imageTextFields = [String]()
    var usernames = [String]()
    var imageFiles = [PFFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Access all users in the database.
        var query = PFUser.query()
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            if let users = objects {
                self.users.removeAll(keepCapacity: true)
                self.imageTextFields.removeAll(keepCapacity: true)
                self.imageFiles.removeAll(keepCapacity: true)
                self.usernames.removeAll(keepCapacity: true)
                
                for object in users {
                    if let user = object as? PFUser {
                        // Populate the users array.
                        self.users[user.objectId!] = user.username!
                    }
                }
            }
            
            // Find out who the active user is following.
            var followedUsersQuery = PFQuery(className: "followers")
            followedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
            followedUsersQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    for object in objects {
                        var followedUser = object["following"] as! String
                        
                        // Get the posts from the followed users.
                        var query = PFQuery(className: "Post")
                        query.whereKey("userID", equalTo: followedUser)
                        query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                            if let objects = objects {
                                for object in objects {
                                    
                                    // Append all the details to the three arrays used to store the information.
                                    self.usernames.append(self.users[object["userID"] as! String]!)
                                    self.imageTextFields.append(object["message"] as! String)
                                    self.imageFiles.append(object["imageFile"] as! PFFile)
                                    self.tableView.reloadData()
                                    
                                }
                            }
 
                        })
                    }
                    
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return usernames.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! cell
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
            if let downloadedImage = UIImage(data: data!) {
                myCell.newImage.image = downloadedImage
                
            }
            
        }
        
        
        
        myCell.userName.text = usernames[indexPath.row]
        
        myCell.imageTextField.text = imageTextFields[indexPath.row]
        
        return myCell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
