//
//  FriendDetailViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/13/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit

class FriendDetailViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Handle the text field’s user input through delegate callbacks.
        
        // Set up views if editing an existing Meal.
        if let friend = friend {
            navigationItem.title = friend.name
            notes=friend.notes
            //notes.text="test"
            //photoImageView.image = meal.photo
            //ratingControl.rating = meal.rating
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "NoteTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoteTableViewCell  else {
            fatalError("The dequeued cell is not an instance of NoteTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let note = notes[indexPath.row]
        
        cell.notes.text = note
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Properties
    var friend: Friend?
    //var notes = [String]()
     var notes=["111","222","333"]
    //@IBOutlet weak var notes: UILabel!
    
}
