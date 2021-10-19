//
//  MainCollectionViewCell.swift
//  SeSAC_04Week
//
//  Created by 양지영 on 2021/10/19.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCollectionViewCell"
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
