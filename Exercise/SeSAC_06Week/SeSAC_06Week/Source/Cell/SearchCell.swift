//
//  SearchCell.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/01.
//

import UIKit

class SearchCell: UITableViewCell {

    static let identifier = "SearchCell"
    
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var searchDate: UILabel!
    @IBOutlet weak var searchContent: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
