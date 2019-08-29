//
//  RemindTableViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 8/1/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//
import os.log
import UIKit
import UserNotifications

class RemindTableViewController: UITableViewController {
    var friend: Friend?
    var friends = [Friend]()
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteDetail: UITextView!
    @IBAction
    public func didChangeDate() {
        txtDate.text = DateFormatter.localizedString(from: datePicker.date, dateStyle: .short, timeStyle: .short)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        didChangeDate()
    UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.noteDetail.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor;
        self.noteDetail.layer.borderWidth = 1.0;
        self.noteDetail.layer.cornerRadius = 8;
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
    
    @IBAction func sendNotification(_ sender: UIButton) {
        //date formatting
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        let dateformatter2 = DateFormatter()
        dateformatter2.dateFormat = "MM-dd-hh-mm"
        //notification
        let content = UNMutableNotificationContent()
        content.title = friend!.name + "'s Reminder"
        content.body = noteDetail.text ?? ""
        content.sound = UNNotificationSound.default
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents = datePicker.calendar.dateComponents([.day, .hour, .minute], from: datePicker.date)
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: false)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        // Create the request
        let uuidString = friend!.name + dateformatter2.string(from: Calendar.current.date(from: dateComponents)!)
        let request = UNNotificationRequest(identifier: uuidString,content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print("error")
                // Handle any errors.
            }
        }

        let now = dateformatter.string(from: NSDate() as Date)
        friend?.notes[now] = "Set a Reminder: " + uuidString +  "\n" + noteDetail.text!
        saveFriends()
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

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
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

}
