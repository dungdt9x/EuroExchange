//
//  CustomTableViewCell.swift
//  EuroRateExchange
//
//  Created by MGX82 on 9/21/15.
//  Copyright © 2015 dungdtiosdeveloper. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_ID: UILabel!
    @IBOutlet weak var lbl_Rate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
