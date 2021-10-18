//
//  TrendCell.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/16.
//

import UIKit


protocol LinkButtonCellDelegate {
    func linkButtonClicked(indexPathRow: Int)
}

class TrendCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var enTitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var koTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var cellDelegate: LinkButtonCellDelegate?
    var cellIndexPath: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        
    }
    
    @IBAction func linkButtonTapped(_ sender: UIButton) {
        
        cellDelegate?.linkButtonClicked(indexPathRow: cellIndexPath)
    }
    
    
    func setUI(){
        backView.setViewShadow()
        posterImageView.setViewTopCornerRadius()
        genreLabel.textColor = .systemGray3
        releaseDateLabel.textColor = .systemGray2
        posterImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
