//
//  FriendTableViewCell.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/12/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    //MARKS: Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var occupation: UILabel!
    @IBOutlet weak var relation: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
