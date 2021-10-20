//
//  SearchViewController.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/15.
//

import UIKit

class SearchViewController: UIViewController {

    var tvShowList = TvShowInfomation()
    
    @IBOutlet weak var searchTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowList.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as? SearchCell else {
            return UITableViewCell()
        }
        
        let row = tvShowList.tvShow[indexPath.row]
        
        cell.titleLabel.text = row.title
        cell.releaseDateLabel.text = row.releaseDate
        
        let titleString = row.title
        let imgTitle = titleToImagetitle(titleString)
        cell.posterImageView.image = UIImage(named: imgTitle)
        
        cell.overviewLabel.text = row.overview
        
        return cell
    }
    
    
}

func titleToImagetitle(_ titleString: String) -> String {
    var imgString = titleString.lowercased()
    imgString = imgString.replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: "_").replacingOccurrences(of: "&", with: "").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "__", with: "_").lowercased()
    
    return imgString
}
