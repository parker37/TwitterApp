//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Ronte' Parker on 2/16/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
    }
    
    
    func loadTweets() {
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": 5]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams,
            success: { (tweets: Any) in
            print(tweets)
            self.tweetArray.removeAll()
//            for tweet in tweets {
//                self.tweetArray.append(tweet)
//            }
            
            self.tableView.reloadData()
            
        }, failure: { Error in
            print("Could not retrieve tweets!")
            print(Error)
        })
        
        
        
    }
    
    
    
    
    
    

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        return cell
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
}
