//
//  Friend.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/12/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//
import os.log
import UIKit

class Friend: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var occupation: String
    var relation: String
    var photo: UIImage?
    var rating: Int
    var notes: [String: String] = [:]
    struct PropertyKey {
        static let name = "name"
        static let occupation = "occupation"
        static let relation = "relation"
        static let photo = "photo"
        static let rating = "rating"
        static let notes = "notes"
    }
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("friends")
    
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
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(occupation, forKey: PropertyKey.occupation)
        aCoder.encode(relation, forKey: PropertyKey.relation)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(notes, forKey: PropertyKey.notes)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
            }
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        let occupation = aDecoder.decodeObject(forKey: PropertyKey.occupation) as! String
        let relation = aDecoder.decodeObject(forKey: PropertyKey.relation) as! String
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as! [String: String]
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating, occupation: occupation, relation: relation,   notes: notes)
    }
}

