//
//  CustomNavigationBar.swift
//  55KarrotUIClone
//
//  Created by 지영 on 2021/12/15.
//

import UIKit
import SnapKit
import Then

class CustomNavigationBar: UIView {

    let townButton = UIButton().then {
        $0.setTitle("성산동", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    let townArrowImage = UIImageView().then {
      $0.frame.size = CGSize(width: 5, height: 5)
      $0.image = UIImage(systemName: "chevron.down")
      $0.tintColor = .black
    }

    let searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .black
    }
    
    let categoryButton = UIButton().then {
        $0.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        $0.tintColor = .black
    }
    
    let notificationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.tintColor = .black
    }
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [townButton, townArrowImage, stackView].forEach {
            self.addSubview($0)
        }
        [searchButton, categoryButton, notificationButton].forEach {
            stackView.addArrangedSubview($0)
        }

        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {

    }
    
}
