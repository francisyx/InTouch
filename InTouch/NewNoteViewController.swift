//
//  NewNoteViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 8/6/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit
import os.log
class NewNoteViewController: UIViewController {

    //MARK: Properties
    var friend: Friend?
    var friends = [Friend]()
    var friendIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notification.text = nil
        // Do any additional setup after loading the view.
        self.textNotes.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor;
        self.textNotes.layer.borderWidth = 1.0;
        self.textNotes.layer.cornerRadius = 8;
    }
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
    //Property
    @IBOutlet weak var textNotes: UITextView!
    @IBOutlet weak var notification: UILabel!
    //adding additional notes
    @IBAction func addNote(_ sender: UIButton) {
        updateSaveButton()
    }

    // MARK: - Navigation

    //MARK: Private Methods
    private func updateSaveButton() {
        //function to decide whether to add notes
        let text = textNotes.text ?? ""
        if text == "" {
            notification.text="Can't save default notes"
            notification.textColor = UIColor.red
            
    }
        else {
            notification.text="notes saved"
            notification.textColor = UIColor.black
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
            let now = dateformatter.string(from: NSDate() as Date)
            
           friend?.notes[now] = textNotes.text ?? ""
           friends[friendIndex!]=friend!
           saveFriends() //friend?.notes.append(textNote.text ?? "")
        }
        
    }
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
