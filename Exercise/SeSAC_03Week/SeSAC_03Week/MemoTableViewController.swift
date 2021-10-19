//
//  MemoTableViewController.swift
//  SeSAC_03week
//
//  Created by 양지영 on 2021/10/12.
//

import UIKit

class MemoTableViewController: UITableViewController {

    let test: [String] = []
    let test2 = [String]()
    
    var list = [Memo]() {
        didSet {
            // savebuttonclicked에서 list.append될 때마다 데이터 저장
            saveData()
        }
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonClicked))

        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        loadData()
        
    }
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 배열에 텍스트뷰의 텍스트 값 추가
     @IBAction func saveButtonClicked(_ sender: UIButton) {
         
         if let text = memoTextView.text {
             //선택된 세그먼트 인덱스값을 가지는 상수
             let segmentIndex = categorySegmentedControl.selectedSegmentIndex
             //세그먼트 인덱스값으로 세그먼트카테고리 string값 가지는 상수
             // TODO: - 질문 카테고리 옵셔널
             // 뷰디드로드에서 다른 추가 번호가 생기거나 지금은 0,1,2로 햇지만 10,20,30과 같이 다른
            // 이상한 번호들로 만들어줄수 있기때문에
             let segmentCategory = Category(rawValue: segmentIndex) ?? .others
             // 메모인스턴스 생성
             let memo = Memo(content: text, category: segmentCategory)
             // list 배열에 추가 -> saveData 호출
             list.append(memo)
         } else {
             print("error")
         }
     }
     
     // 뷰에 뿌려주기 위해 유저디폴트에 있는 메모 리스트 데이터 받아오는 함수
    // UserDefaults -> list
    // 1. 유저디폴트에서 옵셔널 바인딩해서 메모리스트 꺼내오기
    // 2. list에 넣을 memo 배열 변수 선언
    // 3. 유저디폴트에서 category, content 가져와서 Memo타입으로 다시 만들어준 후 memo배열에 append
     func loadData() {
         let userDefaults = UserDefaults.standard
         // 유저디폴트 memoList에 값이 [[string:any]] 타입이면 data에 담을 것
         if let data = userDefaults.object(forKey: "memoList") as? [[String:Any]] {
             // list에 대입할 메모담는 배열 변수
             var memo = [Memo]()
             // 유저디폴트 memoList에 있는 데이터를 memo 변수에 append
             for datum in data {
                 // datum[""]가 type이면 옵셔널 해제
                 guard let category = datum["category"] as? Int else { return }
                 guard let content = datum["content"] as? String else { return }
                 
                 let enumCategory = Category(rawValue: category) ?? .others
                 // 메모 배열에 추가
                 memo.append(Memo(content: content, category: enumCategory))
             }
            // 현재 list에 유저 디폴트 데이터 대입
            self.list = memo
        }
    }
    
    // 리스트에 메모 추가될때 마다 실행되어 유저디폴트에 메모 저장
    // list -> UserDefaults
    // 1. 유저디폴트에 list 넘겨주기 위한 배열(memo) 선언
    // 2. 리스트에 있는 값을 memo에 append + 추가
    // 3. memo로 유저디폴트 만들고 테이블뷰 리로드
    func saveData() {
        //        [
        //            ["category": 1, "content": "dfkjldkf"],
        //            ["category": 2, "content": "dfkjldkf"],
        //        ]
        var memo: [[String:Any]] = [] // [[String:Any]] 배열 안 딕셔너리 형태
        // memo 변수에 현재 list에 있는 데이터를 append
        for i in list {

           //Memo(content: "", catefory: .others)
           //      => ["content" : "" , category: 1]
            let data: [String:Any] = [
                "category": i.category.rawValue, // int값
                "content": i.content
            ]
            // list에 있는 데이터 memo변수에 append
            memo.append(data)
        }
        // memoList 유저디폴트 만들기
        let userDefaults = UserDefaults.standard
        userDefaults.set(memo, forKey: "memoList")
        // 리스트에 메모 추가될 때마다 실행되므로 테이블뷰 리로드
        tableView.reloadData()
    }
    
    
    //옵션: 섹션 수: nuberOfSections(default = 1)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //옵션: 섹션 타이틀: titleForHeaderInSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "섹션 타이틀"
    }

    //필수1. 셀의 갯수: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : list.count
    }

    
    //필수2. 셀의 디자인 및 데이터처리: cellForRowAt
    //재사용매커니즘, 옵셔널체이닝, 옵셔널 바인딩
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        //Early Exit
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "첫번째 섹션입니다 - \(indexPath)"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.imageView?.image = nil
            cell.detailTextLabel?.text = nil
        } else {
            
            let row = list[indexPath.row]
            
            cell.textLabel?.text = row.content
            cell.detailTextLabel?.text = row.category.description
            cell.textLabel?.textColor = .blue
            cell.textLabel?.font = .italicSystemFont(ofSize: 13)
            
            switch row.category {
            case .business:
                cell.imageView?.image = UIImage(systemName: "building.2")
            case .personal:
                cell.imageView?.image = UIImage(systemName: "person")
            case .others    :
                cell.imageView?.image = UIImage(systemName: "square.and.pencil")
            }
            
            cell.imageView?.tintColor = .red
        }
 
        return cell
        
    }
    //옵션 셀 클릭시 기능
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀클릭 \(indexPath.row)")
    }
    
    //옵션 3. 셀의 높이: heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.section == 0 ? 44 : 80
        return indexPath.row == 0 ? 44 : 80
    }
    
    
    // 옵션 셀 스와이프 on/off canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
    
    // 옵션 셀 편집상태 editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1{
            if editingStyle == .delete {
                list.remove(at: indexPath.row)
//                tableView.reloadData()
            }
        }
    }
    
}
