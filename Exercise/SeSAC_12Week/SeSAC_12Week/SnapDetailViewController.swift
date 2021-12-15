//
//  SnapDetailViewController.swift
//  SeSAC_12Week
//
//  Created by 지영 on 2021/12/14.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {
    
    let activateButton: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("클릭", for: .normal)
        button.addTarget(self, action: #selector(activateButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let pushButton: MainActivateButton = {
       let button = MainActivateButton()
        button.setTitle("세팅", for: .normal)
        button.addTarget(self, action: #selector(pushButtonClicked), for: .touchUpInside)
       return button
    }()
    
    
    let firstSquareView: SqureBoxView = {
        let view = SqureBoxView()
        view.label.text = "토스뱅크"
        view.imageView.image = UIImage(systemName: "trash.fill")
        return view
    }()
    
    let secondSquareView: SqureBoxView = {
        let view = SqureBoxView()
        view.label.text = "토스증권"
        view.imageView.image = UIImage(systemName: "chart.xyaxis.line")
        return view
    }()
    
    let thirdSquareView: SqureBoxView = {
        let view = SqureBoxView()
        view.label.text = "고객센터"
        view.imageView.image = UIImage(systemName: "person")
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    let moneyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "13,532원"
        return label
    }()
    
    let descriptionLabel = UILabel()
    
    let redView = UIView()
    let blueView = UIView()
    
    
    @objc func activateButtonClicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        vc.name = "고래밥"
//        let vc = DetailViewController()
        present(vc, animated: true, completion: nil)
    }
    
    @objc func pushButtonClicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //StackView
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstSquareView)
        stackView.addArrangedSubview(secondSquareView)
        stackView.addArrangedSubview(thirdSquareView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view.snp.width).multipliedBy(0.9/1.0)
            $0.height.equalTo(80)
        }

        firstSquareView.alpha = 0
        secondSquareView.alpha = 0
        thirdSquareView.alpha = 0
        
//        UIView.animate(withDuration: 1) {
//            self.firstSquareView.alpha = 1
//        }
        
        UIView.animate(withDuration: 1) {
            self.firstSquareView.alpha = 1
        } completion: { bool in
            
            UIView.animate(withDuration: 1) {
                self.secondSquareView.alpha = 1
            } completion: { bool in
                
                UIView.animate(withDuration: 1) {
                    self.thirdSquareView.alpha = 1
                }
            }
        }

        
        
        view.backgroundColor = .white
        [activateButton, moneyLabel, descriptionLabel, pushButton].forEach {
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
        
        pushButton.snp.makeConstraints { make in
            make.leadingMargin.equalTo(view)
            make.trailingMargin.equalTo(view)
            make.bottom.equalTo(activateButton.snp_topMargin).offset(-20)
            make.height.equalTo(view).multipliedBy(0.1)
            
        }
        
        
//        redView.backgroundColor = .red
//        redView.snp.makeConstraints { make in
////            make.top.equalTo(view)
////            make.leading.equalTo(view)
////            make.trailing.equalTo(view)
////            make.bottom.equalTo(view)
//            make.edges.equalToSuperview().inset(100)
//        }
//
//        redView.snp.updateConstraints { make in
//            make.bottom.equalTo(-500)
//
//        }
//
//        redView.addSubview(blueView)
//        blueView.backgroundColor = .blue
//        blueView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().offset(50)
//        }
        
    }
    
    
    
}
