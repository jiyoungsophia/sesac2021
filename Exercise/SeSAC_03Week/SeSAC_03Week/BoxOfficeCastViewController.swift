//
//  BoxOfficeCastViewController.swift
//  SeSAC_03week
//
//  Created by 양지영 on 2021/10/15.
//

import UIKit

class BoxOfficeCastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var castTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        castTableView.delegate = self
        castTableView.dataSource = self
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "castCell") else { return  UITableViewCell() }
        cell.textLabel?.text = "cast \(indexPath.row)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
