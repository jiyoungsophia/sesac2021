//
//  MainCollectionViewController.swift
//  SeSAC_04Week
//
//  Created by 양지영 on 2021/10/19.
//

import UIKit
import Toast

class MainCollectionViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
   
    var mainArray = Array(repeating: false, count: 100)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.tag = 100
        tagCollectionView.tag = 200

        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        let nibName = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        mainCollectionView.register(nibName, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        let tagNibName = UINib(nibName: TagCollectionViewCell.identifier, bundle: nil)
        tagCollectionView.register(tagNibName, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height:(width / 3) * 1.2 )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        mainCollectionView.collectionViewLayout = layout
        
        let tagLayout = UICollectionViewFlowLayout()
        let tagSpacing: CGFloat = 8
        tagLayout.scrollDirection = .horizontal
        tagLayout.itemSize = CGSize(width: 100, height: 40)
        tagLayout.minimumInteritemSpacing = tagSpacing
        tagLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tagCollectionView.collectionViewLayout = tagLayout
        
        
    }
    
    @objc func heartButtonClicked(selectButton: UIButton) {
        print("\(selectButton.tag) 버튼 클릭")
        
        mainArray[selectButton.tag] = !mainArray[selectButton.tag]  // if true ? false : true
        mainCollectionView.makeToast("\(selectButton.tag + 1)번째 버튼 클릭", duration: 1.0)
        mainCollectionView.reloadItems(at: [IndexPath(item: selectButton.tag, section: 0) ])
        
        
    }
    

}

extension MainCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 200 {
        return 10
        } else {
            return mainArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            
            cell.tagLabel.text = "안녕하세여"
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            
            
            return cell
            
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
            
            let item = mainArray[indexPath.item]
            
            cell.mainImageView.backgroundColor = .blue
            
            let image = item ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            cell.heartButton.setImage(image, for: .normal)
            cell.heartButton.tag = indexPath.item
            cell.heartButton.addTarget(self, action: #selector(heartButtonClicked(selectButton:)), for: .touchUpInside)
            
            
            return cell
            
        }
    }
}
