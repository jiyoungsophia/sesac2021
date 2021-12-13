//
//  SqureBoxView.swift
//  SeSAC_12Week
//
//  Created by 지영 on 2021/12/13.
//

import UIKit

class SqureBoxView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    //required 붙는이유 - protocol
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadView()
        loadUI()
    }

    
    func loadView() {
//        let view2 = Bundle.main.loadNibNamed("SqureBoxView", owner: self, options: nil)?.first as! UIView
        let view = UINib(nibName: "SqureBoxView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        self.addSubview(view)
    }
    
    func loadUI() {
        label.font = .boldSystemFont(ofSize: 13)
        label.text = "마이페이지"
        label.textAlignment = .center
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .black
    }
}
