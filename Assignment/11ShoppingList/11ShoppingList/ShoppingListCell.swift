//
//  ShoppingListCell.swift
//  11ShoppingList
//
//  Created by 양지영 on 2021/10/14.
//

import UIKit

class ShoppingListCell: UITableViewCell {

    
    
    @IBOutlet weak var cellBackView: UIView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    

}
