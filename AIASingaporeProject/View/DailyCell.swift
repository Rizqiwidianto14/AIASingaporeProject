//
//  DailyCell.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 19/12/20.
//

import UIKit

class DailyCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var symbolLabelOne: UILabel!
    @IBOutlet weak var openLabelOne: UILabel!
    @IBOutlet weak var lowLabelOne: UILabel!
    @IBOutlet weak var symbolValueOne: UILabel!
    @IBOutlet weak var openValueOne: UILabel!
    @IBOutlet weak var lowValueOne: UILabel!
    
    @IBOutlet weak var symbolLabelTwo: UILabel!
    @IBOutlet weak var openLabelTwo: UILabel!
    @IBOutlet weak var lowLabelTwo: UILabel!
    @IBOutlet weak var symbolValueTwo: UILabel!
    @IBOutlet weak var openValueTwo: UILabel!
    @IBOutlet weak var lowValueTwo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
