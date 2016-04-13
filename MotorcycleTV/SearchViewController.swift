//
//  SearchViewController.swift
//  MotorcycleTV
//
//  Created by Fumitoshi Ogata on 2016/04/12.
//  Copyright © 2016年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    var result = [Dictionary<String, AnyObject>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data1: Dictionary = ["title": "Manufacturer", "category_id": 1]
        let data2: Dictionary = ["title": "Scene", "category_id": 2]
        let data3: Dictionary = ["title": "Categories", "category_id": 3]
        self.result.append(data1)
        self.result.append(data2)
        self.result.append(data3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }

    
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        //selectedImage = UIImage(named:"\(imgArray[indexPath.row])")
        //if selectedImage != nil {
            // SubViewController へ遷移するために Segue を呼び出す
            performSegueWithIdentifier("toMovieCategoryList",sender: nil)
        //}
    }

    
    //toMovieCategoryList
    override func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : SearchListCell = table.dequeueReusableCellWithIdentifier("search_cell", forIndexPath: indexPath) as! SearchListCell
        cell.setCell(self.result[indexPath.row]["title"] as! String,categoryId:1)
        return cell
    }

}
