//
//  TwitterTimelineCell.swift
//  TwitterDemo
//
//  Created by Fernando on 4/22/16.
//  Copyright © 2016 Specialist. All rights reserved.
//

import UIKit

class TwitterTimelineCell: UITableViewCell {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var profileNameLbl: UILabel!
    @IBOutlet var tweetTextLbl: UILabel!
    @IBOutlet var timestampLbl: UILabel!
    
    var tweet: Tweet! {
        didSet{
            profileNameLbl.text = tweet.tweetUserScreenName
            profileImg.setImageWithURL(tweet.tweetUserProfileImg)
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
