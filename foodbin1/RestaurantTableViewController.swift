//
//  RestaurantTableViewController.swift
//  foodbin1
//
//  Created by NDHU_CSIE on 2020/10/22.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
     var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
var restaurantIsVisited = Array(repeating: false, count: 21)

    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        //cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
        return cell
    }
    

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    // Create an option menu as an action sheet
    let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
    if let popoverController = optionMenu.popoverPresentationController {
        if let cell = tableView.cellForRow(at: indexPath) {
            popoverController.sourceView = cell
            popoverController.sourceRect = cell.bounds
            }
        }

    
    // Add Call action
    let callActionHandler = { (action:UIAlertAction!) -> Void in
        let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertMessage, animated: true, completion: nil)
    }
    let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
    optionMenu.addAction(callAction)
    
    // Check-in action
    let checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {
        (action:UIAlertAction!) -> Void in
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        self.restaurantIsVisited[indexPath.row] = true
    })
    optionMenu.addAction(checkInAction)

    //Undo check in action
    let uncheckInAction = UIAlertAction(title: "Undo Check in", style: .default, handler: {
         (action:UIAlertAction!) -> Void in
         
         let cell = tableView.cellForRow(at: indexPath)
         cell?.accessoryType = .none
         self.restaurantIsVisited[indexPath.row] = false
     })
     optionMenu.addAction(uncheckInAction)
    
    // Add actions to the menu
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    optionMenu.addAction(cancelAction)
    
    // Display the menu
    present(optionMenu, animated: true, completion: nil)
    
     // Deselect a row
    tableView.deselectRow(at: indexPath, animated: false)
    }
}
