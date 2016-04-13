//
//  SearchListCell.swift
//  MotorcycleTV
//
//  Created by Fumitoshi Ogata on 2016/04/12.
//  Copyright © 2016年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

class SearchListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var categoryId : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("xxxxx")
        //self.titleLabel.text = "xxxx"
        // Configure the view for the selected state
    }

    
    func setCell(titleText:String,categoryId:Int){
        self.titleLabel.text = titleText
        self.categoryId = categoryId
    }
}
