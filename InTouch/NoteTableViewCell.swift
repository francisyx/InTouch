//
//  NoteTableViewCell.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/24/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    //MARKS: Properties
    @IBOutlet weak var notes: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
