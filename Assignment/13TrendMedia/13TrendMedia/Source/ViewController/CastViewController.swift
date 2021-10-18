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
}

extension CastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell" ) as? CastCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = castDic[indexPath.row]["name"]
        cell.castLabel.text = castDic[indexPath.row]["cast"]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 11
    }
    
}
