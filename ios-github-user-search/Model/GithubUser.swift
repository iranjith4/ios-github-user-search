//
//  GithubUser.swift
//  ios-github-user-search
//
//  Created by ranjith on 26/03/18.
//  Copyright © 2018 ir4. All rights reserved.
//

import Foundation

struct GithubUser {
    let login: String;
    let id: Int
    let avatarURL: String
    
    init(userObject: [String: Any]) {
        self.login = userObject["login"] as! String
        self.id = userObject["id"] as! Int
        self.avatarURL = userObject["avatar_url"] as! String
    }
}
