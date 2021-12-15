//
//  SqureBoxView.swift
//  SeSAC_12Week
//
//  Created by 지영 on 2021/12/13.
//

import UIKit

class SqureBoxView: TapAnimationView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        loadUI()
    }
    
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

class TapAnimationView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
}
