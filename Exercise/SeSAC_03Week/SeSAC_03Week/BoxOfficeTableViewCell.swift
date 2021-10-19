//
//  BoxOfficeTableViewCell.swift
//  SeSAC_03week
//
//  Created by 양지영 on 2021/10/13.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {

    static let identifier = "BoxOfficeTableViewCell"
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
