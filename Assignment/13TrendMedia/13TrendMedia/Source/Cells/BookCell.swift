//
//  BookCell.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/19.
//

import UIKit

class BookCell: UICollectionViewCell {

    @IBOutlet weak var bookBackView: UIView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookRateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookBackView.setViewCornerRadius()
        bookImageView.setViewTopCornerRadius()
        bookImageView.contentMode = .scaleAspectFill
        bookTitleLabel.textColor = .white
        bookRateLabel.textColor = .white
    }
    
    

}
