//
//  User.swift
//  TwitterDemo
//
//  Created by Fernando on 4/20/16.
//  Copyright © 2016 Specialist. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var screenName: String?
    var profileUrl: NSURL?
    var tagline: String?
    
    var dictionary: NSDictionary?
    
    static var _currentUser: User?
    static let userDidLogoutNotification = "UserDidLogout"
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        
        if let profileImg = profileUrlString {
            profileUrl = NSURL(string: profileImg)
        }
        
        tagline = dictionary["description"] as? String
    }
    
    class var currentUser: User? {
        get{
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
                
                if let userDataTemp = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userDataTemp, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user1 = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user1.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            
            defaults.synchronize()
        }
    }
    
}
