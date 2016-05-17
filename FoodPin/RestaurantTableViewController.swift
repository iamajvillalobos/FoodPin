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

        return cell
    }

}
