//
//  CustomCellLayout.swift
//  MotorcycleTV
//
//  Created by Fumitoshi Ogata on 2016/02/23.
//  Copyright © 2016年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageWithURL(url: NSURL) -> NSURLSessionDownloadTask {
        let session = NSURLSession.sharedSession()
        let downloadTask = session.downloadTaskWithURL(url, completionHandler: {
            [weak self] url, response, error in
            print(error)
            if error == nil && url != nil {
                if let data = NSData(contentsOfURL: url!) {
                    if let image = UIImage(data: data) {
                        dispatch_async(dispatch_get_main_queue()) {
                            if let strongSelf = self {
                                strongSelf.image = image
                            }
                        }
                    }
                }
            }
            })
        downloadTask.resume()
        return downloadTask
    }
}


class CustomCellLayout: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.blackColor()
        self.contentView.backgroundColor = UIColor.blackColor()
    }
    
    func setCell(titleText:String,descriptionText:String, published_at:String, thumbnailUrl:String){
        //self.watchCntLabel.text = published_at
        self.titleLabel.text = titleText
        self.thumbnail.backgroundColor = UIColor.blackColor()
        self.thumbnail.clipsToBounds = true
        self.thumbnail.contentMode = UIViewContentMode.ScaleAspectFill
        let myUrl:NSURL = NSURL(string:thumbnailUrl) as NSURL!
        self.thumbnail.loadImageWithURL(myUrl)
    }
}
