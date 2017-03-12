//
//  NewsItemTableViewCell.swift
//  MyWater-Flint
//
//  Created by John Collins on 2/11/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class NewsItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
