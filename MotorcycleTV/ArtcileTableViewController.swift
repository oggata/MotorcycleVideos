//
//  ArtcileTableViewController.swift
//  MotorcycleTV
//
//  Created by Fumitoshi Ogata on 2016/02/24.
//  Copyright © 2016年 Fumitoshi Ogata. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArtcileTableViewController: UITableViewController {

    var activityIndicator : UIActivityIndicatorView!
    var delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var loadedArticleData : Array<Dictionary<String,AnyObject>> = []
    var loadCommentData : Array<Dictionary<String,AnyObject>> = []
    var lvideoId : String = ""
    var firstLoadTime = 0
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBAction func backButtonDidTouch(sender: AnyObject) {
        print("back")
        //self.openAlbum()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //private var myRightButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorColor = UIColor.clearColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.title = "My Navigation"
        
        // 右ボタンを作成する.
        //myRightButton = UIBarButtonItem(title: "RightBtn", style: .Plain, target: self, action: "onClickMyButton:")
        //myRightButton.tag = 2
        //self.navigationItem.rightBarButtonItem = myRightButton
        
        
        
        let nib_detail:UINib = UINib(nibName: "MovieDetailLayout", bundle: nil)
        self.tableView.registerNib(nib_detail, forCellReuseIdentifier: "movie_detail_layout")
        let nib_cell:UINib = UINib(nibName: "CommentCellLayout", bundle: nil)
        self.tableView.registerNib(nib_cell, forCellReuseIdentifier: "comment_cell_layout")
        
        let _localVideoId :String = self.delegate.videoId2
        let _url = Const.API_ENDPOINT_VIDEOS + "?key=" + Const.API_KEY + "&part=snippet,statistics&id=" + _localVideoId
        Alamofire.request(.GET, _url).responseJSON { response in
            let json = JSON(response.result.value!)
            for (_,subJson):(String, JSON) in json["items"] {
                var dic = Dictionary<String, AnyObject>()
                dic["videoId"] = subJson["id"].string!
                dic["title"] = subJson["snippet"]["title"].string!
                dic["description"] = subJson["snippet"]["description"].string!
                dic["url"] = subJson["snippet"]["thumbnails"]["default"]["url"].string!
                dic["width"] = 120
                dic["height"] = 90
                dic["published_at"] = subJson["snippet"]["publishedAt"].string!
                dic["channelId"] = subJson["snippet"]["channelId"].string!
                dic["likeCount"] = subJson["statistics"]["likeCount"].string!
                dic["viewCount"] = subJson["statistics"]["viewCount"].string!
                dic["favoriteCount"] = subJson["statistics"]["favoriteCount"].string!
                dic["dislikeCount"] = subJson["statistics"]["dislikeCount"].string!
                dic["commentCount"] = subJson["statistics"]["commentCount"].string!
                self.loadedArticleData.append(dic)
            }
        }
        
        let _url2 = Const.API_ENDPOINT_COMMENT + "?key=" + Const.API_KEY + "&part=snippet&videoId=" + _localVideoId
        Alamofire.request(.GET, _url2).responseJSON { response in
            let json = JSON(response.result.value!)
            for (_,subJson):(String, JSON) in json["items"] {
                var dic3 = Dictionary<String, AnyObject>()
                //print(subJson["snippet"]["topLevelComment"]["snippet"])
                dic3["textDisplay"] = subJson["snippet"]["topLevelComment"]["snippet"]["textDisplay"].string
                dic3["authorProfileImageUrl"] = subJson["snippet"]["topLevelComment"]["snippet"]["authorProfileImageUrl"].string
                dic3["authorDisplayName"] = subJson["snippet"]["topLevelComment"]["snippet"]["authorDisplayName"].string
                dic3["publishedAt"] = subJson["snippet"]["topLevelComment"]["snippet"]["publishedAt"].string
                dic3["likeCount"] = subJson["snippet"]["topLevelComment"]["snippet"]["likeCount"].string
                self.loadCommentData.append(dic3)
            }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.loadedArticleData.count + self.loadCommentData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("movie_detail_layout") as! MovieDetailLayout
            cell.setCell(
                self.loadedArticleData[0]["title"] as! String,
                videoId: self.loadedArticleData[0]["videoId"] as! String,
                detail: self.loadedArticleData[0]["description"] as! String,
                viewCount: self.loadedArticleData[0]["viewCount"] as! String
            )
            return cell
        }else{
            let cell2 = tableView.dequeueReusableCellWithIdentifier("comment_cell_layout") as! CommentCellLayout
            cell2.setCell(
                self.loadCommentData[indexPath.row-1]["textDisplay"] as! String,
                thumbnailUrl: self.loadCommentData[indexPath.row-1]["authorProfileImageUrl"] as! String,
                autthorName: self.loadCommentData[indexPath.row-1]["authorDisplayName"] as! String
            )
            return cell2
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 600
        }else{
            return 150
        }
    }

}
