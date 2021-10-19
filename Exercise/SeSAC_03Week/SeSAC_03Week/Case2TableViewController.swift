//
//  Case2TableViewController.swift
//  SeSAC_03week
//
//  Created by 양지영 on 2021/10/12.
//

import UIKit

class Case2TableViewController: UITableViewController {

    var totalList: [String] = ["공지사항", "실험실", "버전 정보"]
    var personalList: [String] = ["개인/보안", "알림", "채팅", "멀티프로필"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return totalList.count
        } else if section == 1 {
            return personalList.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else { return UITableViewCell() }
        
        cell.textLabel?.font = .systemFont(ofSize: 17)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = totalList[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = personalList[indexPath.row]
        } else {
            cell.textLabel?.text = "고객센터/도움말"
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "전체 설정"
        } else if section == 1 {
            return "개인 설정"
        } else {
            return "기타"
        }
    }
}
