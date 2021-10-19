//
//  BookViewController.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/19.
//

import UIKit

class BookViewController: UIViewController {

    private let cellIdentifier: String = "BookCell"
    
    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    var tvShowList = TvShowInfomation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }
    
    func setCollectionView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        bookCollectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: width / 2 )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        bookCollectionView.collectionViewLayout = layout
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShowList.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? BookCell else {
            return UICollectionViewCell()
        }
        let row = tvShowList.tvShow[indexPath.row]
        cell.bookTitleLabel.text = row.title
        cell.bookRateLabel.text = "\(row.rate)"
        
        let url = URL(string: row.backdropImage)
        cell.bookImageView.kf.setImage(with: url)
        
        return cell
    }
}
