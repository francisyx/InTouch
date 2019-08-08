//
//  FriendDetailViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/13/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit

class FriendDetailViewController: UITableViewController {
 
  //MARK: Properties
  var friend: Friend?
  var notes = [String]()
  
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
    self.tableView.reloadData()
    //
    
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
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        switch(segue.identifier ?? "") {
            
            
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
