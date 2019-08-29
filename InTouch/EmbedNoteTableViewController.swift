//
//  FriendDetailViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/13/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//
import os.log
import UIKit
import UserNotifications
class EmbedNoteTableViewController: UITableViewController {
    
    //MARK: Properties
    var friend: Friend?
    var friends = [Friend]()
    //var notes: [String: String] = [:]
    var notes: [(key: String, value: String)] = []
    
    //@IBOutlet weak var notes: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Handle the text field’s user input through delegate callbacks.
        
    }
    
    // This gets called everytime a view appears (not just when it loads). It
    // is a good place to test if data is being passed between view controllers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        
        // Set up views if editing an existing Meal.
        if let friend = friend {
            notes=friend.notes.sorted(by: >)
            //notes.text="test"
            //photoImageView.image = meal.photo
            //ratingControl.rating = meal.rating
        }
        self.tableView.reloadData()
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
        let noteValue = notes[indexPath.row].value
        let noteKey = notes[indexPath.row].key
        cell.notes.text = noteValue
        cell.notesKey.text = noteKey
        cell.notes.lineBreakMode = .byWordWrapping
        //cell.notes.preferredMaxLayoutWidth = 330;
        cell.notes.numberOfLines = 0
        return cell
    }

    // Override to support conditional editing of the table view.ß
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let noteKey2 = notes[indexPath.row].key
            let noteContent=friend!.notes[noteKey2];
            //subroutine to cancel reminder if deleting a reminder from notes
            if noteContent!.contains("Set a Reminder") {
                let array=noteContent!.components(separatedBy: "\n");
                let reminder=array[0].components(separatedBy: "a Reminder: "); UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminder[1]])
                
            }
            friend!.notes[noteKey2]=nil
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveFriends()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    /*
     @IBAction func unwindToNotes(sender: UIStoryboardSegue) {
     if let sourceViewController = sender.source as? NewNoteViewController {
     // Add a new meal.
     let newIndexPath = IndexPath(row: notes.count, section: 0)
     notes.append(sourceViewController.textNote.text ?? "")
     tableView.insertRows(at: [newIndexPath], with: .automatic)
     }
     }*/
    //MARK: Private Methods
    private func saveFriends() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(friends, toFile: Friend.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Friends successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save friends...", log: OSLog.default, type: .error)
        }
    }
    
    
}
