//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Fernando on 4/21/16.
//  Copyright © 2016 Specialist. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]!
    var currentUser: User!
    
    @IBOutlet var twitterTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        twitterTable.dataSource = self
        twitterTable.delegate = self
        twitterTable.rowHeight = UITableViewAutomaticDimension
        twitterTable.estimatedRowHeight = 80.5
        
        loadTweets()
        loadCurrentUser()
        
        twitterTable.reloadData()
    }
    
    func loadTweets() {
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) in
            
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text)
                print(tweet.time)
                print(tweet.favouritesCount)
                
            }
            self.twitterTable.reloadData()
            
        }) { (error: NSError) in
            print(error.localizedDescription)
        }
    }
    
    func loadCurrentUser() {
        TwitterClient.sharedInstance.currentAccount({ (user: User) in
            self.currentUser = user
        }) { (error: NSError) in
            print(error.localizedDescription)
        }
    }

    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = twitterTable.dequeueReusableCellWithIdentifier("TimelineCell", forIndexPath: indexPath) as! TwitterTimelineCell
        cell.profileImg.setImageWithURL(tweets[indexPath.row].tweetUserProfileImg)
        cell.timestampLbl.text = tweets[indexPath.row].timeString
        cell.tweetTextLbl.text = tweets[indexPath.row].text
        
        return cell
    }

}
