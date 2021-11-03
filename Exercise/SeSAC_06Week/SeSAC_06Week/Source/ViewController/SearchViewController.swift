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
    
    // 도큐먼트 경로 -> 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath)
                .appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        return nil
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        // 1. 이미지 저장할 경로 설정: 도큐먼트 폴더(.documentDirectory), FileManager
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        let imageURL = documentDirectory.appendingPathComponent(imageName)
               
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기(원래는 자동으로 된다고,,)
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path){
            //4-2. 기존경로에 있는 이미지 삭제(원래 자동으로 삭제됨)
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완")
            } catch {
                print("이미지 삭제하지 못했습니다")
            }
        }
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
        cell.searchImageView.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpeg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    // 본래는 화면 전환 + 값 전달 후 새로운 화면에서 수정이 적합
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskToUpdate = tasks[indexPath.row]
        //1. 수정 - 레코드에 대한 값 수정
        try! localRealm.write{
            taskToUpdate.diaryTitle = "새로 수정"
            taskToUpdate.content = "본래는 화면 전환 + 값 전달 후 새로운 화면에서 수정이 적합"
            tableView.reloadData()
        }
        //2. 일괄 수정
//        try! localRealm.write{
//            tasks.setValue("일괄 수정", forKey: "content")
//            tableView.reloadData()
//        }
        //3. 수정: pk 기준으로 수정할 때 사용(권장하지않음) 밸류 넣은값 수정하면서 나머지 초기화
//        try! localRealm.write {
//            let update = UserDiary(value: ["_id": taskToUpdate._id, "diaryTitle": "제목만 바꾸기"])
//            localRealm.add(update, update: .modified)
//            tableView.reloadData()
//        }
        //4.
//        try! localRealm.write {
//            localRealm.create(UserDiary.self, value: ["_id": taskToUpdate._id, "diaryTitle": "제목만 바꾸기"], update: .modified)
//            tableView.reloadData()
//        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let row = tasks[indexPath.row]

        
        try! localRealm.write{
            // 순서 중요
            deleteImageFromDocumentDirectory(imageName: "\(row._id).jpeg")
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
}
