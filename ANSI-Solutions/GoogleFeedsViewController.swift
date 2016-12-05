//
//  GoogleFeedsViewController.swift
//  ANSI-Solutions
//
//  Created by yashwanth on 12/4/16.
//  Copyright © 2016 srikanth. All rights reserved.
//

import Foundation
import UIKit

class GoogleFeedsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    var userFeeds = UserFeeds(googleFeed: [])
    var isRefreshing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //including estimated row height and setting automatic dimension to handle dynamic heights for cells
        tableView.estimatedRowHeight = 124.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.layoutIfNeeded()
        
        //removing blank lines rom table view
        tableView.tableFooterView = UIView()
        
        //        //initializing refresh control and setting it's action to the method refreshData
        tableView.refreshControl = UIRefreshControl ()
        tableView.refreshControl!.addTarget(self, action: #selector(self.refreshData(_:)), for: UIControlEvents.valueChanged)
        getPostsJSON("https://alpha-api.app.net/stream/0/posts/stream/global")
    }
    
    @IBAction func logOut(_ sender: AnyObject) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userFeeds.googleFeed.count
    }
    
    //populates the tableview cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "GoogleFeedsTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        
        let users = self.userFeeds.googleFeed[indexPath.row].user
        cell.userNameLabel.text = users.username
        cell.userNameLabel.sizeToFit()
        cell.avatarImage.image = stringToImage(string: users.avatarLink!)
        
        cell.detailedTextLabel.sizeToFit()
        cell.detailedTextLabel.numberOfLines = 0
        cell.detailedTextLabel.text = self.userFeeds.googleFeed[indexPath.row].text
        cell.avatarImage.layer.cornerRadius = 8.0;
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
    }
    
    //gets response from API and populates tableview with the parsed data
    func getPostsJSON(_ URL : String){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let session = URLSession.shared
        let url = Foundation.URL(string: URL)!
        let networkTask = session.dataTask(with: url, completionHandler : {data, response, error -> Void in
            if (error == nil){
                do {
                    let dictArray = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
                    
                    guard let resultArray = dictArray?["data"] as? Array<NSDictionary> else { return }
                    
                    for model in resultArray
                    {
                        if let userDict = model["user"] as? NSDictionary {
                            
                            if let userName = userDict["username"] {
                                // If we have a valid user name get 'text' and avatar URL
                                var url: String?
                                
                                
                                
                                // Get avatar image url
                                if let avatarData = userDict["avatar_image"] {
                                    
                                    if let avatarDict = avatarData as? NSDictionary {
                                        url = avatarDict.value(forKey: "url") as! String?
                                    }
                                    
                                    if let text = model["text"] {
                                        self.userFeeds.googleFeed.append(GoogleFeed(text: (text as? String)!, createdAt: "", user: User(username: userName as! String, avatarLink: (url)!)))
                                    }
                                }
                            }
                        }
                        
                    }
                    DispatchQueue.main.async(execute: {
                        self.tableView!.reloadData()
                        self.isRefreshing = false;
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    })
                } catch {
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    })
                }
            }else{
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                })
            }
        })
        
        networkTask.resume()
    }
    
    //function to prepopulate an array with thumbnails, making the request quicker and handling possible reusable cell issues
    func stringToImage(string : String) -> UIImage? {
        let imageURL = NSURL.init(string: string)
        let data = NSData(contentsOf: imageURL! as URL)
        let image = UIImage(data: data! as Data)
        return image!
    }
    
    func refreshData(_ refreshControl: UIRefreshControl) {
        if (!isRefreshing){
            isRefreshing = true
            getPostsJSON("https://alpha-api.app.net/stream/0/posts/stream/global")        }
    }
}
