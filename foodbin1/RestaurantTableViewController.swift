//
//  RestaurantTableViewController.swift
//  foodbin1
// foodpin latest
//  Created by NDHU_CSIE on 2020/10/22.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    var restaurantNames = ["baseball","basketball","football","other"]
    var restaurantImages = ["baseball","basketball","football","other"]
    var navigationImages = ["baseball_photo","basketball_photo","football_photo","other_photo"]
    
    
    var ilike = String()
    @IBOutlet weak var likeLabel: UILabel!
    
    var restaurantIsVisited = Array(repeating: false, count: 4)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]//optional changing
        
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        if restaurantIsVisited[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let likeAction = UIContextualAction(style: .normal, title: "Like")
        { (action, sourceView, completionHandler) in
            
            if let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
            {
                if cell.accessoryType == .none{
                    self.ilike += self.restaurantNames[indexPath.row]
                    
                    cell.accessoryType = .checkmark
                }
                
            }
            self.likeLabel.text = "I Like:  " + self.ilike
            
            completionHandler(true)
        }
        
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [likeAction])
        
        
        return swipeConfiguration
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let dislikeAction = UIContextualAction(style: .normal, title: "Dislike") { (action, sourceView, completionHandler) in
            
            if let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
            {
                if cell.accessoryType == .checkmark{
             
                    self.ilike += self.restaurantNames.remove(at: indexPath.row)
                    cell.accessoryType = .none
                }
                
            }
            self.likeLabel.text = "I Like:  " + self.ilike
            
            
            completionHandler(true)
        }
        
        
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [dislikeAction])
        
        
        return swipeConfiguration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurantImageName = navigationImages[indexPath.row]
            }
        }
    }
    
}
