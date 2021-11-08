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
    
    func configureCell(row: UserDiary) {
        searchTitle.text = row.diaryTitle
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        searchDate.text = format.string(from: row.writeDate)
        
        searchContent.text = row.content
        searchImageView.image = ImageManager.shared.loadImageFromDocumentDirectory(imageName: "\(row._id).jpeg")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
