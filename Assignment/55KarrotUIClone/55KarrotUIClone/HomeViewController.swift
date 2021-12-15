//
//  HomeViewController.swift
//  55KarrotUIClone
//
//  Created by 지영 on 2021/12/15.
//

import UIKit
import SnapKit
import Then

class HomeViewController: UIViewController {

    let customNavigationBar = CustomNavigationBar().then {
        $0.backgroundColor = .white
    }
    
    let tableView = UITableView().then {
        $0.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        self.navigationController?.navigationBar.isHidden = true
        configure()
    }
    
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(customNavigationBar)
        view.addSubview(tableView)
        
        customNavigationBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.size.equalTo(44)
            make.centerX.equalToSuperview()
            
        }
        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(view)
            make.top.equalTo(self.customNavigationBar.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        
        
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier) as! HomeCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 6
    }
}
