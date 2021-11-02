//
//  BoxOfficeViewController.swift
//  13TrendMedia
//
//  Created by 지영 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON

class BoxOfficeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    
    var boxOfficeList: [BoxOfficeModel] = []
    var yesterday = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getData(yesterday: getYesterDay)
    }

    func getYesterDay() -> String {
        
        let date = Date().dayBefore
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        yesterday = "\(format.string(from: date))"
        return yesterday
    }
    
    func getData(yesterday: () -> String) {
        
        self.dateTextField.text = "\(yesterday())"
        
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Constants.koficKey)&targetDt=\(yesterday())"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let rank = item["rank"].stringValue
                    let title = item["movieNm"].stringValue
                    let date = item["openDt"].stringValue

                    let data = BoxOfficeModel(rankNumber: rank, movieTitle: title, openDate: date)

                    self.boxOfficeList.append(data)
                }

                self.tableView.reloadData()
                print(self.boxOfficeList)
                
            case .failure(let error):
                print(error)
            }
        }
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
