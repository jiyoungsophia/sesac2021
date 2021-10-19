//
//  BoxOfficeTableViewController.swift
//  SeSAC_03week
//
//  Created by 양지영 on 2021/10/13.
//

import UIKit

class BoxOfficeTableViewController: UITableViewController {

    // pass data1. 데이터를 전달 받을 공간
    var titleSpcae: String?
    
    var movieInformation = MovieInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonClicked))
                // pass data2. 표현
        title = titleSpcae ?? "내용 없을 때 타이틀"
    }
    
    // @IBAction
    @objc
    func closeButtonClicked() {
        
        // Push - Pop
        // Push: Dismiss X, Present: Pop X
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInformation.movie.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        let row = movieInformation.movie[indexPath.row]
        
        cell.postImageView.backgroundColor = .red
        cell.postImageView.image = UIImage(named: row.title)
        cell.titleLabel.text = row.title
        cell.releaseLabel.text = row.releaseDate
        cell.overviewLabel.text = row.overview
        cell.overviewLabel.numberOfLines = 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Movie", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "BoxOfficeDetailViewController") as? BoxOfficeDetailViewController else {
            print("ERROR")
            return
        }
        
        let row = movieInformation.movie[indexPath.row]

//        vc.releaseDate = row.releaseDate
//        vc.overview = row.overview
//        vc.runtime = row.runtime
//        vc.rate = row.rate
//        vc.movieTitle = row.title
        vc.movieData = row
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
