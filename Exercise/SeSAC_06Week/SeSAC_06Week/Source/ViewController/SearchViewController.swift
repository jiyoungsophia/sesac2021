//
//  SearchViewController.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: SearchCell.identifier, bundle: nil)
        searchTableView.register(nibName, forCellReuseIdentifier: SearchCell.identifier)
        searchTableView.delegate = self
        searchTableView.dataSource = self
    
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "regDate", ascending: false)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTableView.reloadData()
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        
        cell.searchTitle.text = row.diaryTitle
        cell.searchDate.text = "\(row.writeDate)"
        cell.searchContent.text = row.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    
}
