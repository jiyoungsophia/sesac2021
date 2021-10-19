//
//  CastViewController.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/15.
//

import UIKit

class CastViewController: UIViewController {
    
    let castDic = [
        ["name" : "리처드 해리스", "cast": "덤블도어 교장선생님"],
        ["name" : "이안 하트", "cast": "퀴리누스 퀴렐 교수"],
        ["name" : "존 허트", "cast": "Mr 올리밴더"],
        ["name" : "앨런 릭먼", "cast": "스네이프 교수"],
        ["name" : "피오나 쇼", "cast": "페투니아 이모"],
        ["name" : "매기 스미스", "cast": "맥고나걸 교수"],
        ["name" : "레이프 파인즈", "cast": "볼드모트"],
        ["name" : "워윅 데이비스", "cast": "플리트윅 교수"],
        ["name" : "줄리 월터스", "cast": "위즐리 부인"],
        ["name" : "데이빗 브래들리", "cast": "아구스 필치"],
        ["name" : "헬레나 보넘 카터", "cast": "벨라트릭스 레스트랭"],
        ["name" : "게리 올드만", "cast": "시리우스 블랙"],
        ["name" : "로비 콜트레인", "cast": "루베우스 해그리드"],
        ["name" : "이멜다 스탠턴", "cast": "돌로레스 엄브릿지"]
    ]
    
    var tvShowData : TvShow?
    var isClicked = false
    
    @IBOutlet weak var headerBackImageView: UIImageView!
    @IBOutlet weak var headerPosterImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var castTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        castTableView.delegate = self
        castTableView.dataSource = self
        
        setData()
    }
    
    func setData() {

        let url = URL(string: tvShowData?.backdropImage ?? "")
        headerBackImageView.kf.setImage(with: url)
        headerPosterImageView.kf.setImage(with: url)
        headerTitleLabel.text = tvShowData?.title
        
    }
    
    @objc func overviewButtonClicked(selectButton: UIButton) {
        isClicked = !isClicked
        castTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
     
    }
}

extension CastViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return castDic.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell" ) as? OverviewCell else {
                return UITableViewCell()
            }
            
            cell.overviewLabel.text = tvShowData?.overview
            
            let image = isClicked ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            cell.overviewButton.setImage(image, for: .normal)
            cell.overviewLabel.numberOfLines = isClicked ? 0 : 2
            cell.overviewButton.addTarget(self, action: #selector(overviewButtonClicked(selectButton:)), for: .touchUpInside)
        
            
            return cell
        
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell" ) as? CastCell else {
                return UITableViewCell()
            }
            
            cell.nameLabel.text = castDic[indexPath.row]["name"]
            cell.castLabel.text = castDic[indexPath.row]["cast"]
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else if indexPath.section == 1 {
            return UIScreen.main.bounds.height / 11
        } else {
            return 0
        }
        
    }
    
    
    
}
