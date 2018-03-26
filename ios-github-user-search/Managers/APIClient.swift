//
//  APIClient.swift
//  ios-github-user-search
//
//  Created by ranjith on 26/03/18.
//  Copyright © 2018 ir4. All rights reserved.
//

import Foundation

class APIClient: NSObject {
    enum Url: String {
        case searchUser = "https://api.github.com/search/users"
    }
    
    func getUsers(params: [String: AnyObject]) {
        
    }
    
}
