//
//  HomeTableViewCell.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/08.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    static let identifier = "HomeTableViewCell"
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [String] = [] {
        didSet {
            collectionView.reloadData()
            categoryLabel.text = "\(data.count)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.backgroundColor = .yellow
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        if collectionView.tag == 0 {
            cell.imageView.backgroundColor = .brown

        } else {
            cell.imageView.backgroundColor = .magenta
        }
        cell.contentLabel.text = data[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 테이블 뷰 셀의 indexPath
        if collectionView.tag == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        } else {
            return CGSize(width: 150, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView.tag == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.tag == 0 ? 0 : 10
    }
}
