//
//  TrendViewController.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/15.
//

import UIKit

class TrendViewController: UIViewController {

    private let cellIdentifier: String = "TrendCell"
    
    @IBOutlet weak var buttonBackView: UIView!
    @IBOutlet weak var trendTableView: UITableView!
    
    var tvShowList = TvShowInfomation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        buttonBackView.setViewShadow()
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    func setTableView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        trendTableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        print("눌리니")
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return tvShowList.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier ) as? TrendCell else {
            return UITableViewCell()
        }
        
        let row = tvShowList.tvShow[indexPath.row]
        
        cell.genreLabel.text = "#\(row.genre)"
        cell.enTitleLabel.text = row.title
        
        let url = URL(string: row.backdropImage)
        //DispatchQueue를 쓰는 이유 -> 이미지가 클 경우 이미지를 다운로드 받기 까지 잠깐의 멈춤이 생길수 있다. (이유 : 싱글 쓰레드로 작동되기때문에)
        //DispatchQueue를 쓰면 멀티 쓰레드로 이미지가 클경우에도 멈춤이 생기지 않는다.
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.posterImageView.image = UIImage(data: data!)
            }
        }
        
        cell.rateLabel.text = "\(row.rate)"
        cell.koTitleLabel.text = row.title
        cell.releaseDateLabel.text = row.releaseDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Cast", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CastViewController") as! CastViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
