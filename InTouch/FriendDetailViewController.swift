//
//  FriendDetailViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/13/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController {
 
  //MARK: Properties
  var friend: Friend?
  var notes = [String]()
  
  //@IBOutlet weak var notes: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Handle the text field’s user input through delegate callbacks.
    
  }
  
  // This gets called everytime a view appears (not just when it loads). It
  // is a good place to test if data is being passed between view controllers
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //
    
    // Set up views if editing an existing Meal.
    if let friend = friend {
      navigationItem.title = friend.name
      //notes.text="test"
      //photoImageView.image = meal.photo
      //ratingControl.rating = meal.rating
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
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        switch(segue.identifier ?? "") {
        case "EmbedNote":
            guard let EmbedNoteTableViewController = segue.destination as? EmbedNoteTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let selectedFriend = self.friend
            EmbedNoteTableViewController.friend = selectedFriend
        case "SetReminder":
            guard let RemindTableViewController = segue.destination as? RemindTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let selectedFriend = self.friend
            RemindTableViewController.friend = selectedFriend
        case "SegueToNewNote":
            guard let NewNoteViewController = segue.destination as? NewNoteViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let addNote = sender as? UIButton else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            let selectedFriend = self.friend
            
            
            NewNoteViewController.friend = selectedFriend
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
        
    }
    /*
    @IBAction func unwindToNotes(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewNoteViewController {
            // Add a new meal.
            let newIndexPath = IndexPath(row: notes.count, section: 0)
            notes.append(sourceViewController.textNote.text ?? "")
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }*/
  
  
  
}
