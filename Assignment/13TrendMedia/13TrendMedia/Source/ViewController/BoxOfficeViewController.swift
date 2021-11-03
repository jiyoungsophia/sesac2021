//
//  BoxOfficeViewController.swift
//  13TrendMedia
//
//  Created by 지영 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class BoxOfficeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    
    var boxOfficeList: [BoxOfficeModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let localRealm = try! Realm()
    var tasks: Results<BoxOfficeModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        loadData(searchDate: getYesterDay())
        
        print("Realm is located at: \(localRealm.configuration.fileURL!)")
    }
    
    func loadData(searchDate: String) {
        self.dateTextField.text = "\(searchDate)"
        
        tasks = localRealm.objects(BoxOfficeModel.self).filter("searchDate == '\(searchDate)'")
        if tasks.count != 0 {
            boxOfficeList = Array(tasks)
        } else {
            getData(searchDate: searchDate)
        }
    }
    
    func getData(searchDate: String) {

        BoxOfficeAPIService.shared.fetchBoxOfficeData(searchDate: searchDate) { (code, json) in
            switch code {
            case 200:
                print(json)
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let rank = item["rank"].stringValue
                    let title = item["movieNm"].stringValue
                    let date = item["openDt"].stringValue

                    let data = BoxOfficeModel(rankNumber: rank, movieTitle: title, openDate: date, searchDate: searchDate)

                    self.boxOfficeList.append(data)
                    try! self.localRealm.write {
                        self.localRealm.add(data)
                    }
                }
                print("api 호출")
                
            case 400:
                print(json)
        
            default:
                print("오류")
            }

        }
    }

    func getYesterDay() -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        let date = format.string(from: yesterday)
        return date
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        //textfield 글자수 제한, 잘못된 입력 알려주기
        boxOfficeList.removeAll()
        loadData(searchDate: dateTextField.text ?? getYesterDay())
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BoxOfficeTableViewCell" ) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        let row = boxOfficeList[indexPath.row]
        cell.rankLabel.text = row.rankNumber
        cell.titleLabel.text = row.movieTitle
        cell.dateLabel.text = row.openDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 20
        
    }

}
