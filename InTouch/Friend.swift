//
//  Friend.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/12/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit

class Friend {
    
    //MARK: Properties
    
    var name: String
    var occupation: String
    var relation: String
    var photo: UIImage?
    var rating: Int
    //var notes: Array<String> = Array()
    var notes: [String: String] = [:]

    //MARK: Initialization

    init?(name: String, photo: UIImage?, rating: Int, occupation: String, relation: String, notes: [String: String] = [:]) {
        
        // Initialization should fail if the name is empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.occupation = occupation
        self.relation = relation
        self.notes = notes
        
    }
}

