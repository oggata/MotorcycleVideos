//
//  CommentCellLayout.swift
//  MotorcycleTV
//
//  Created by Fumitoshi Ogata on 2016/03/01.
//  Copyright © 2016年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

class CommentCellLayout: UITableViewCell {

    @IBOutlet weak var commentLabel: UITextView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(commentText:String,thumbnailUrl:String,autthorName:String){
        //self.watchCntLabel.text = published_at
        self.commentLabel.text = commentText

        self.thumbnail.backgroundColor = UIColor.blackColor()
        self.thumbnail.clipsToBounds = true
        self.thumbnail.contentMode = UIViewContentMode.ScaleAspectFill
        let myUrl:NSURL = NSURL(string:thumbnailUrl) as NSURL!
        self.thumbnail.loadImageWithURL(myUrl)
        self.authorNameLabel.text = autthorName as String
    }
}
