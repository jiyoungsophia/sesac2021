//
//  DetailViewController.swift
//  SeSAC_12Week
//
//  Created by 지영 on 2021/12/13.
//

import UIKit

class DetailViewController: UIViewController {

    let titleLabel = UILabel()
    let captionLabel = UILabel()
    let activateButton: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("다음", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        tabBarItem.image = UIImage(systemName: "person")
        tabBarItem.title = "디테일"
        
        [titleLabel,captionLabel, activateButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        view.backgroundColor = .white
        setTitleLabelConstraints()
        setCaptionLabelConstraints()
        setActivateButtonConstraints()
    }
    
    func setActivateButtonConstraints() {
        
        NSLayoutConstraint.activate([
            activateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activateButton.widthAnchor.constraint(equalToConstant: 300),
            activateButton.heightAnchor.constraint(equalToConstant: 50),
            activateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setCaptionLabelConstraints() {
        captionLabel.text = "맞춤 정보를 알려드려요"
        captionLabel.backgroundColor = .darkGray
        captionLabel.font = .systemFont(ofSize: 12)
        captionLabel.textAlignment = .center
        
        
        let topConstraint = NSLayoutConstraint(item: captionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: captionLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: captionLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: captionLabel, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 0.5, constant: 0)
        
        view.addConstraints([topConstraint, centerX, width, heightConstraint])
    }

    func setTitleLabelConstraints() {
        
        titleLabel.text = "관심 있는 회사\n3개를 선택해주세요"
        titleLabel.backgroundColor = .lightGray
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
//        titleLabel.frame = CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width - 200, height: 80)
        
        //NSLayoutConstraints
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
        
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
        
        NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80).isActive = true
        
    }
}
