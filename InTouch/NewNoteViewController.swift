//
//  NewNoteViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 8/6/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {

    //MARK: Properties
    var friend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notification.text = nil
        // Do any additional setup after loading the view.
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
    @IBOutlet weak var notification: UILabel!
    @IBOutlet weak var textNote: UITextField!
    //adding additional notes
    @IBAction func addNote(_ sender: UIButton) {
        updateSaveButton()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Private Methods
    private func updateSaveButton() {
        //function to decide whether to add notes
        let text = textNote.text ?? ""
        if text.isEmpty {
            notification.text="Can't save empty notes"
            notification.textColor = UIColor.red
            
    }
        else {
            notification.text="notes saved"
            notification.textColor = UIColor.black
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy/MM/dd hh:mm"
            let now = dateformatter.string(from: NSDate() as Date)
           friend?.notes[now] = textNote.text ?? "" //friend?.notes.append(textNote.text ?? "")
        }
        
    }
}
