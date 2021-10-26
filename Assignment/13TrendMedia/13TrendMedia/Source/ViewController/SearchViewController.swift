//
//  SearchViewController.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/15.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {

    var tvShowList = TvShowInfomation()
    var movieData: [MovieModel] = []
    
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        fetchMovieData()
    }
    
    //네이버 영화 네트워크 통신
    func fetchMovieData() {
        if let query = "스파이더맨".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1"
            
            let header: HTTPHeaders = ["X-Naver-Client-Id": "\(Constants.naverKey)",
                                       "X-Naver-Client-Secret" : "\(Constants.naverSecretKey)"
                                        ]
            
                    
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    for item in json["items"].arrayValue {
                        let value = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let userRating = item["userRating"].stringValue
                        let sub = item["subtitle"].stringValue
                        let pubDate = item["pubDate"].stringValue
                        
                        
                        let data = MovieModel(titleData: value, imageData: image, linkData: link, userRatingData: userRating, subtitleData: sub, pubDateData: pubDate)
                        
                        self.movieData.append(data)
    
                    }
                    
//                    print(self.movieData)
                    // 중요!!!
                    self.searchTableView.reloadData()
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        
        
    }
    
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movieData.count, #function)
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as? SearchCell else {
            return UITableViewCell()
        }
        
        let row = movieData[indexPath.row]
        
        cell.titleLabel.text = row.titleData
        
        cell.releaseDateLabel.text = row.pubDateData
        
        cell.overviewLabel.text = row.linkData
        
        // kf: placeholder
        let url = URL(string: row.imageData)
        cell.posterImageView.kf.setImage(with: url)
        
        
        return cell
    }
    
    
}

func titleToImagetitle(_ titleString: String) -> String {
    var imgString = titleString.lowercased()
    imgString = imgString.replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: "_").replacingOccurrences(of: "&", with: "").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "__", with: "_").lowercased()
    
    return imgString
}
