//
//  IntradayCell.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 17/12/20.
//

import UIKit

class IntradayCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var openValue: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var highValue: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var lowValue: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
