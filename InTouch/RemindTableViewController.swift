//
//  RemindTableViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 8/1/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit
import UserNotifications

class RemindTableViewController: UITableViewController {
    var friend: Friend?
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteDetail: UITextField!
    @IBOutlet weak var buttonNotif: UILabel!
    @IBAction
    public func didChangeDate() {
        txtDate.text = DateFormatter.localizedString(from: datePicker.date, dateStyle: .short, timeStyle: .short)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        didChangeDate()
        buttonNotif.text=nil
    UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        print("test1")
        let content = UNMutableNotificationContent()
        content.title = friend?.name ?? "" + "'s Reminder"
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
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print("error")
                // Handle any errors.
            }
        }
        print("test2")
        buttonNotif.text="Redminer Scheduled Successfully"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

