//
//  MovieDetailLayout.swift
//  MotorcycleTV
//
//  Created by Fumitoshi Ogata on 2016/02/23.
//  Copyright © 2016年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

class MovieDetailLayout: UITableViewCell {

    @IBOutlet weak var movieView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var dislikeCountLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    
    @IBAction func likeButtonDidTouch(sender: AnyObject) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(titleText:String,videoId:String,detail:String,viewCount:String){
        self.movieView.userInteractionEnabled = true
        self.titleLabel.text = titleText
        let url_string = "https://www.youtube.com/embed/" + videoId + "?feature=player_detailpage"
        let url:NSURL = NSURL(string: url_string)!
        let urlRequest: NSURLRequest = NSURLRequest(URL: url)
        self.movieView.allowsInlineMediaPlayback = true;
        self.movieView.loadRequest(urlRequest)
        self.descriptionLabel.text = detail as String
        self.viewCountLabel.text = viewCount as String
    }
}
