//
//  HistoryTableViewCell.swift
//  SuperPlayerPomodoro
//
//  Created by Raphael Araújo on 1/13/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var currentStatusLabel: UILabel!
    @IBOutlet weak var pastTimeLabel: UILabel!
    @IBOutlet weak var stoppedTimeLabel: UILabel!
    
    var pomodoro : RLMPomodoro?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
