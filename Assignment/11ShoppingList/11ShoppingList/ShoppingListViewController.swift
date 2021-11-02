//
//  ShoppingListViewController.swift
//  11ShoppingList
//
//  Created by 양지영 on 2021/10/14.
//

import UIKit
import RealmSwift


class ShoppingListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var shoppingListTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var isChecked: [Bool] = [false]
    var isStarred: [Bool] = [false]
    
    let localRealm = try! Realm()
    var tasks: Results<ShoppingMemo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        headerView.layer.cornerRadius = 10
        addButton.layer.cornerRadius = 10
        addButton.setTitleColor(.black, for: .normal)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tasks = localRealm.objects(ShoppingMemo.self).sorted(byKeyPath: "regDate", ascending: false)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        // if문 두번으로밖에 해결 못하는 일일까,, 맘에 안들어,,
        if let text = shoppingListTextField.text {
            if text == "" {
                print("쇼핑리스트를 적어주세요") // 나중에 toast나 alert로 바꾸기
            } else {
                let task = ShoppingMemo(shopMemo: text, check: isChecked[sender.tag], star: isStarred[sender.tag], regDate: Date())
                try! localRealm.write {
                    localRealm.add(task)
                }
                tableView.reloadData()
            }
        } else {
            print("error")
        }
    }

    
    @objc func checkButtonClicked(selectButton: UIButton) {
        let taskToUpdate = tasks[selectButton.tag]
        try! localRealm.write {
            taskToUpdate.check = !taskToUpdate.check
        }
        tableView.reloadRows(at: [IndexPath(row: selectButton.tag, section: 0)], with: .automatic)
    }
    
    @objc func starButtonClicked(selectButton: UIButton) {
        let taskToUpdate = tasks[selectButton.tag]
        try! localRealm.write {
            taskToUpdate.star = !taskToUpdate.star
        }
        tableView.reloadRows(at: [IndexPath(row: selectButton.tag, section: 0)], with: .automatic)
    }
}


extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath) as? ShoppingListCell else {
            return UITableViewCell()
        }
        cell.cellBackView.layer.cornerRadius = 10
        
        cell.memoLabel.text = tasks[indexPath.row].shopMemo
        
        let check = tasks[indexPath.row].check
        let checkImage = check ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        cell.checkButton.setImage(checkImage, for: .normal)
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked(selectButton:)), for: .touchUpInside)
        
        let star = tasks[indexPath.row].star
        let starImage = star ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        cell.starButton.setImage(starImage, for: .normal)
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(starButtonClicked(selectButton:)), for: .touchUpInside)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = tasks[indexPath.row]
            try! localRealm.write {
                localRealm.delete(taskToDelete)
            }
            
            tableView.reloadData()
        }
    }
}

