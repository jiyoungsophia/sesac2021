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
        cell.posterImageView.kf.setImage(with: url)
        
        cell.rateLabel.text = "\(row.rate)"
        cell.koTitleLabel.text = row.title
        cell.releaseDateLabel.text = row.releaseDate
        
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

extension TrendViewController: LinkButtonCellDelegate {
    func linkButtonClicked(indexPathRow: Int) {
        let vc = self.storyboard?.instantiateViewController(identifier: "WebViewController") as! WebViewController
        
        vc.titleData = tvShowList.tvShow[indexPathRow].title
        self.present(vc, animated: true, completion: nil)
        
 
    }
}
