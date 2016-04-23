//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Fernando on 4/20/16.
//  Copyright © 2016 Specialist. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String!
    var time: NSDate!
    var timeString: String!
    var retweetCount: Int! = 0
    var favouritesCount: Int = 0
    var tweetUserDict: NSDictionary!
    var tweetUserScreenName: String!
    var tweetUserProfileImg: NSURL!
    
    init(dictionary: NSDictionary) {
        
        text = dictionary["text"] as? String
        
        if let tweetUser1 = dictionary["user"] as? Dictionary<String,AnyObject> {
            self.tweetUserDict = tweetUser1
            
            if let tweetUserScreenNameString = tweetUserDict["name"] as? String {
                tweetUserScreenName = tweetUserScreenNameString
            }
            let tweetUserProfileImgUrlString = tweetUserDict["profile_image_url_https"] as? String
            
            if let tweetUserProfileImageUrl = tweetUserProfileImgUrlString {
                tweetUserProfileImg = NSURL(string: tweetUserProfileImageUrl)
            }
            
        }
        
        // Here, what we are saying is "if dictionary["retweet_count"] exists, use it as an integer, if not, retweetCount = 0
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favouritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStamp = timeStampString {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            time = dateFormatter.dateFromString(timeStamp)
            timeString = dateFormatter.stringFromDate(time)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        return tweets
    }
    
}
