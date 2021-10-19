//
//  OverviewCell.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/19.
//

import UIKit

class OverviewCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
