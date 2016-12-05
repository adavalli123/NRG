//
//  GoogleFeed.swift
//  ANSI-Solutions
//
//  Created by yashwanth on 12/4/16.
//  Copyright © 2016 srikanth. All rights reserved.
//

import Foundation

class GoogleFeed {
    var text = ""
    var createdAt: String?
    
    var user: User
    
    init(text: String, createdAt: String, user: User)
    {
        self.text = text
        self.createdAt = createdAt
        self.user = user
    }
}

class User: NSObject{
    var username: String?
    var avatarLink: String?
    
    init(username: String, avatarLink: String) {
        self.username = username
        self.avatarLink = avatarLink
    }
}

class UserFeeds{
    var googleFeed: [GoogleFeed]!
    
    init(googleFeed: [GoogleFeed]) {
        self.googleFeed = googleFeed
    }
}
