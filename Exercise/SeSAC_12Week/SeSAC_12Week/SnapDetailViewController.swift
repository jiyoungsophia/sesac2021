//
//  SnapDetailViewController.swift
//  SeSAC_12Week
//
//  Created by 지영 on 2021/12/14.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {
    
    let activateButton = MainActivateButton()
    
    let moneyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "13,532원"
        return label
    }()
    
    let descriptionLabel = UILabel()
    
    let redView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        [activateButton, moneyLabel, descriptionLabel, redView].forEach {
            view.addSubview($0)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(80)
        }
        
        activateButton.snp.makeConstraints {
            $0.leadingMargin.equalTo(view).offset(10)
            $0.trailingMargin.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view).multipliedBy(0.1)
        }
        
        redView.backgroundColor = .red
        redView.snp.makeConstraints { make in
//            make.top.equalTo(view)
//            make.leading.equalTo(view)
//            make.trailing.equalTo(view)
//            make.bottom.equalTo(view)
            make.edges.equalToSuperview().inset(100)
        }
        
        redView.snp.updateConstraints { make in
            make.bottom.equalTo(-500)

        }
        
        redView.addSubview(blueView)
        blueView.backgroundColor = .blue
        blueView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(50)
        }
        
    }
    
    
    
}
