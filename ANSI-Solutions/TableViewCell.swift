//
//  TableViewCell.swift
//  ANSI-Solutions
//
//  Created by yashwanth on 12/4/16.
//  Copyright © 2016 srikanth. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell{
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var detailedTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
