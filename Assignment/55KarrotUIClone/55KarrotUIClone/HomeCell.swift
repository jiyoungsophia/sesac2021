//
//  HomeCell.swift
//  55KarrotUIClone
//
//  Created by 지영 on 2021/12/15.
//

import UIKit
import SnapKit
import Then

class HomeCell: UITableViewCell {

    static let identifier = "HomeCell"
    
    let thumbnailImageView = UIImageView().then {
        $0.image = UIImage(named: "IMG_5426")
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let titleLabel = UILabel().then {
        $0.text = "마더스베이비 발판"
        $0.font = .systemFont(ofSize: 16)
    }
    
    let townLabel = UILabel().then {
        $0.text = "당근마켓"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .gray
    }
    
    let priceLabel = UILabel().then {
        $0.text = "3,000원"
        $0.font = .boldSystemFont(ofSize: 17)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [thumbnailImageView, titleLabel, townLabel, priceLabel].forEach {
            contentView.addSubview($0)
        }
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(contentView).inset(16)
            make.centerY.equalTo(contentView)
            make.width.equalTo(self.thumbnailImageView.snp.height).multipliedBy(1.0/1.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.thumbnailImageView.snp.right).offset(16)
            make.top.equalTo(self.thumbnailImageView.snp.top).inset(8)
        }
        
        townLabel.snp.makeConstraints { make in
            make.left.equalTo(self.titleLabel.snp.left)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(self.titleLabel.snp.left)
            make.top.equalTo(self.townLabel.snp.bottom).offset(8)
        }
    }
    
    
}
