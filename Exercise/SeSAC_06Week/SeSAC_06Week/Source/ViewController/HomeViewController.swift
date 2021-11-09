//
//  HomeViewController.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let array = [
        Array(repeating: "a", count: 20),
        Array(repeating: "b", count: 10),
        Array(repeating: "c", count: 15),
        Array(repeating: "d", count: 2),
        Array(repeating: "e", count: 14),
        Array(repeating: "f", count: 22),
        Array(repeating: "g", count: 17)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Home" //navigationtab, tabbar
        tableView.delegate = self
        tableView.dataSource = self
      
    }

    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Content", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.data = array[indexPath.row]
        cell.collectionView.tag = indexPath.row // section 한개일때 사용

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row == 1 ? 300 : 170
    }
}

