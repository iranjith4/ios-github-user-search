//
//  Extensions.swift
//  ios-github-user-search
//
//  Created by ranjith on 26/03/18.
//  Copyright © 2018 ir4. All rights reserved.
//

import Foundation

extension String {
    var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}
