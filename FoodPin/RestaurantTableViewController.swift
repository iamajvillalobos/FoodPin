//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Arman Jon Villalobos on 14/05/2016.
//  Copyright © 2016 Arman Jon Villalobos. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurantModel = RestaurantModel()
    var restaurantIsVisited = [Bool](count: 21, repeatedValue: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantModel.names.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell

        cell.nameLabel.text = restaurantModel.names[indexPath.row]
        cell.locationLabel.text = restaurantModel.locations[indexPath.row]
        cell.typeLabel.text = restaurantModel.types[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantModel.images[indexPath.row])
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .Checkmark : .None

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Create option menu
        let optionMenu = UIAlertController(title: nil, message: "What do you want?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let callAction = UIAlertAction(title: "Call 123-000-\(indexPath.row)", style: .Default, handler: {
            (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable",
                message: "Sorry, this feature is not yet available right now.",
                preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertMessage.addAction(alertAction)
            self.presentViewController(alertMessage, animated: true, completion: nil)
        })
        let isVisitedAction = UIAlertAction(title: "I've been here", style: .Default, handler: {
            (action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            self.restaurantIsVisited[indexPath.row] = true
            cell?.accessoryType = .Checkmark
        })
        let isNotVisitedAction = UIAlertAction(title: "I've not been here", style: .Default, handler: {
            (action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            self.restaurantIsVisited[indexPath.row] = false
            cell?.accessoryType = .None
        })
        
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(callAction)
        
        if restaurantIsVisited[indexPath.row] {
            optionMenu.addAction(isNotVisitedAction)
        } else {
            optionMenu.addAction(isVisitedAction)
        }
        
        // Display the menu
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // Social sharing button
        let shareAction = UITableViewRowAction(style: .Default, title: "Share", handler: {
            (action, indexPath) -> Void in
            let defaultText = "Just checking in at \(self.restaurantModel.names[indexPath.row])"
            if let imageToShare = UIImage(named: self.restaurantModel.images[indexPath.row]) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            }
            
        })
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: {
            (action, indexPath) -> Void in
            
            // Delete entry
            self.restaurantModel.names.removeAtIndex(indexPath.row)
            self.restaurantModel.types.removeAtIndex(indexPath.row)
            self.restaurantModel.locations.removeAtIndex(indexPath.row)
            self.restaurantModel.images.removeAtIndex(indexPath.row)
            self.restaurantIsVisited.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        })
        
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }

}
