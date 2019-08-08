//
//  NotificationViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/25/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit
import EventKit

class NotificationViewController: UIViewController {

    //MARK: -Property
    let eventStore = EKEventStore()
    var calendars: [EKCalendar]?
    override func viewWillAppear(_ animated: Bool) {
               checkCalendarAuthorizationStatus()
            }
    func checkCalendarAuthorizationStatus(){
        eventStore.requestAccess(to: EKEntityType.reminder, completion:
        {(granted, error) in
        if !granted {
        print("Access to store not granted")
        }
        })
    }
    
}
