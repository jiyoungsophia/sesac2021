//
//  ShoppingListViewController.swift
//  11ShoppingList
//
//  Created by 양지영 on 2021/10/14.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    var list = [ShoppingList]() {
        didSet{
            saveData()
        }
    }
    
    let shoppingList: [String] = ["쇼핑리스트1", "쇼핑리스트2", "쇼핑리스트3", "쇼핑리스트4"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var shoppingListTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
        
    }
    
    func setUI() {
        
        headerView.layer.cornerRadius = 10
        addButton.layer.cornerRadius = 10
        addButton.setTitleColor(.black, for: .normal)
        
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let text = shoppingListTextField.text {
            
        } else {
            print("error")
        }
        
    }
    
    func loadData() {
        
    }
    
    func saveData() {
        
    }
}


extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath) as? ShoppingListCell else {
            return UITableViewCell()
        }
        
       cell.memoLabel.text = shoppingList[indexPath.row]
        cell.cellBackView.layer.cornerRadius = 10
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

