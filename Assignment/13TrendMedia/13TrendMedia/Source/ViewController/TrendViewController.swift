//
//  TrendViewController.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/15.
//

import UIKit
import Kingfisher

class TrendViewController: UIViewController {
    
    private let cellIdentifier: String = "TrendCell"
    
    @IBOutlet weak var buttonBackView: UIView!
    @IBOutlet weak var trendTableView: UITableView!
    
    var tvShowList = TvShowInfomation()
    var tvData: [TrendModel] = []
    
    var startPage = 1
    var totalPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrendData() // 여기서 데이터 다 받아오는데 페이지네이션이 의미가잇나,,?
        setTableView()
        buttonBackView.setViewShadow()
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    func getTrendData() {
        TrendAPIService.shared.fetchTrendData { (code, json) in
            switch code {
            case 200:
                //                print(json)
                
                for result in json["results"].arrayValue {
                    // TODO: - 장르 수정
                    let genreId = result["genre_ids"][0].stringValue
                    let enTitle = result["name"].stringValue
                    let title = result["original_name"].stringValue
                    let image = result["backdrop_path"].stringValue
                    let rateInput = result["vote_average"].doubleValue
                    let rate = "\(round(rateInput * 10) / 10)"
                    let release = result["first_air_date"].stringValue
                    
                    self.totalPages = result["total_pages"].intValue
                    
                    let data = TrendModel(genreIDData: genreId, enTitleData: enTitle, posterImageData: image, rateData: rate, koTitleData: title, releaseData: release)
                    
                    self.tvData.append(data)
                }
                self.trendTableView.reloadData()
                
                
            case 400:
                print(json)
                
            default:
                print("오류")
            }
        }
    }
    
    func setTableView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        trendTableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        trendTableView.prefetchDataSource = self
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Book", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func pinButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Theater", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TheaterViewController") as! TheaterViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func filmButtonClicked(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "BoxOfficeViewController") as! BoxOfficeViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier ) as? TrendCell else {
            return UITableViewCell()
        }
        
        let row = tvData[indexPath.row]
        
        cell.genreLabel.text = row.genreIDData
        cell.enTitleLabel.text = row.enTitleData
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(row.posterImageData)")
        cell.posterImageView.kf.setImage(with: url)
        
        cell.rateLabel.text = row.rateData
        cell.koTitleLabel.text = row.koTitleData
        cell.releaseDateLabel.text = row.releaseData
        
        cell.cellDelegate = self
        cell.cellIndexPath = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Cast", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CastViewController") as! CastViewController
        
        vc.tvShowData = tvShowList.tvShow[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
 
    
}

extension TrendViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if tvData.count - 1 == indexPath.row && tvData.count < totalPages {
                startPage = min(startPage + 1, totalPages)
                getTrendData()
//                print("페이지네이션: \(indexPaths)")
            }
        }
    }
    
    // 취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
}


extension TrendViewController: LinkButtonCellDelegate {
    func linkButtonClicked(indexPathRow: Int) {
        let vc = self.storyboard?.instantiateViewController(identifier: "WebViewController") as! WebViewController
        
        vc.titleData = tvData[indexPathRow].enTitleData
        
        self.present(vc, animated: true, completion: nil)
    }
}
