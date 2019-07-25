//
//  FriendTableViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/12/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit
import os.log

class FriendTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var friends = [Friend]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Load the sample data.
        loadSampleFriends()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FriendTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        // Fetches the appropriate friend for the data source layout.
        let friend = friends[indexPath.row]
        // Configure the cell...
        cell.name.text = friend.name
        cell.photoImageView.image = friend.photo
        cell.ratingControl.rating = friend.rating
        cell.occupation.text = friend.occupation
        cell.relation.text = friend.relation

        return cell
    }

    /*
    // Override to support conditional editing of the table view.ß
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue:
        UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let friendDetailViewController = segue.destination as? FriendDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedFriendCell = sender as? FriendTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedFriendCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedFriend = friends[indexPath.row]
            friendDetailViewController.friend = selectedFriend
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    

    //MARK: Private Methods
    
    private func loadSampleFriends() {
        let photo1 = UIImage(named: "p1")
        let photo2 = UIImage(named: "p2")
        let photo3 = UIImage(named: "p3")
        let photo4 = UIImage(named: "p4")
        
        guard let friend1 = Friend(name: "Frank", photo: photo1, rating: 5, occupation: "Doctor", relation: "Uncle",notes: ["I have a note","I have another note","I have third note"]) else {
            fatalError("Unable to instantiate friend1")
        }
        
        guard let friend2 = Friend(name: "Justine", photo: photo2, rating: 4,occupation: "Banker", relation: "Friend",notes: []) else {
            fatalError("Unable to instantiate friend2")
        }
        
        guard let friend3 = Friend(name: "Tom", photo: photo3, rating: 3,occupation: "Student", relation: "Friend",notes: []) else {
            fatalError("Unable to instantiate friend3")
        }
        guard let friend4 = Friend(name: "Christina", photo: photo4, rating: 3,occupation: "Designer", relation: "Colleague",notes: []) else {
            fatalError("Unable to instantiate friend4")
        }
        friends += [friend1, friend2, friend3, friend4]
    }
    //MARK: Actions
    @IBAction func unwindToFriendList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? FriendViewController, let friend = sourceViewController.friend {
            // Add a new meal.
            let newIndexPath = IndexPath(row: friends.count, section: 0)
            friends.append(friend)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
