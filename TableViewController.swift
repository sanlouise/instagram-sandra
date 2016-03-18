//
//  TableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Sandra Adams-Hallie on Mar/14/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController {
    
    // Arrays to later import data from Parse
    var usernames = [""]
    var userIDs = [""]
    //Store follower-followed users in dictionary. Boolean, either true of false.
    var isFollowing = ["":false]
    var refresher: UIRefreshControl!
    
    func refresh() {
        
        // Retrieve users from Parse.
        let query = PFUser.query()
        // Find every user.
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            // Check if objects exists.
            if let users = objects {
                // Clear the existing arrays to remove double exiting values.
                self.usernames.removeAll(keepCapacity: true)
                self.userIDs.removeAll(keepCapacity: true)
                self.isFollowing.removeAll(keepCapacity: true)
                
                //Users is AnyObject Type, needs to be converted into PFUser.
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        // The current user should not appear in the user list.
                        if user.objectId != PFUser.currentUser()?.objectId {
                            // Add these values.
                            self.usernames.append(user.username!)
                            self.userIDs.append(user.objectId!)
                            
                            let query = PFQuery(className: "followers")
                            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                            query.whereKey("following", equalTo: user.objectId!)
                            
                            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                                
                                // If objects is not nil, then unwrap it.
                                if let objects = objects {
                                    // If 0, user does not follow other user.
                                    if objects.count > 0 {
                                        self.isFollowing[user.objectId!] = true
                                    } else {
                                        self.isFollowing[user.objectId!] = false
                                    }
                                }
                                //Make sure that both match.
                                if self.isFollowing.count == self.usernames.count {
                                    
                                    //Reload data in table. Place it here so, not outside, so that the isFollowing can be run beforehand.
                                    self.tableView.reloadData()
                                    // End refreshing when pulled down if the data is updated.
                                    self.refresher.endRefreshing()
                                    
                                }
                                
                            })
                        }
                    }
                }
                
            }
            
        })


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Refresh user list when the view is dragged downwards.
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull down to refresh")
        // Run the refresh function when someone has pulled the table down.
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
        refresh()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernames.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        // Add names as how they are stored.
        cell.textLabel?.text = usernames[indexPath.row]
        let followedObjectId = userIDs[indexPath.row]
        if isFollowing[followedObjectId] == true {
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        return cell
    }
    
    //Happens when user clicks on a cell.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        let followedObjectId = userIDs[indexPath.row]
        // User is not yet a follower.
        if isFollowing[followedObjectId] == false {
            
            isFollowing[followedObjectId] = true
            // Add a checkmark to the cell.
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            // Instatiate following.
            let following = PFObject(className: "followers")
            // Follow user that user taps on.
            following["following"] = userIDs[indexPath.row]
            //ID of current user now links to id he/she follows.
            following["follower"] = PFUser.currentUser()?.objectId
            // Keep records.
            following.saveInBackground()
            
        } else {
            
            isFollowing[followedObjectId] = false
            // Get rid of the checkmark when unfollowing a user.
            cell.accessoryType = UITableViewCellAccessoryType.None
            // Remove follower from Parse.
            let query = PFQuery(className: "followers")
            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
            query.whereKey("following", equalTo: userIDs[indexPath.row])
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if let objects = objects {
                    for object in objects {
                        object.deleteInBackground()
                        
                    }
                }
                
                
            })
        }
        
    }
}
