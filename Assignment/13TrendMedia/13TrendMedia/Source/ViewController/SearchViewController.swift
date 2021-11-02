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
    
    var startPage = 1
    var totalCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self
        searchBar.delegate = self

    }
    
    //네이버 영화 네트워크 통신
    func fetchMovieData(query: String) {
        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=10&start=\(startPage)"
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": "\(Constants.naverKey)",
                "X-Naver-Client-Secret" : "\(Constants.naverSecretKey)"
            ]
            
            DispatchQueue.global().async {
                AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
                        self.totalCount = json["total"].intValue
                        print("전체 갯수: \(self.totalCount)")
                        
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
            
                        DispatchQueue.main.async {
                            // 중요!!!
                            self.searchTableView.reloadData()
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
            
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
extension SearchViewController: UISearchBarDelegate {
    //검색 버튼(키보드 리턴키) 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text {
            movieData.removeAll()
            startPage = 1
            fetchMovieData(query: text)
        }
        
    }
    
    //취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        movieData.removeAll()
        searchTableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)

    }
    
    //서치바에 커서 깜빡이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.setShowsCancelButton(true, animated: true)

    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching  {
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
        if let url = URL(string: row.imageData) {
        cell.posterImageView.kf.setImage(with: url)
        } else {
            cell.posterImageView.image = UIImage(systemName: "star")
        }
        
        return cell
    }
    
    // 셀이 화면에 보이기전에(cellForRowAt) 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            // 사용자가 보고있는 셀이 가장 마지막 셀이면
            if movieData.count - 1 == indexPath.row && movieData.count < totalCount {
                startPage += 10
                guard let text = searchBar.text else { return }
                fetchMovieData(query: text)
            }
        }
    }
    // 취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
}

func titleToImagetitle(_ titleString: String) -> String {
    var imgString = titleString.lowercased()
    imgString = imgString.replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: "_").replacingOccurrences(of: "&", with: "").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "__", with: "_").lowercased()
    
    return imgString
}
