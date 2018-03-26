//
//  GithubUsersViewController.swift
//  ios-github-user-search
//
//  Created by ranjith on 26/03/18.
//  Copyright © 2018 ir4. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class GithubUsersViewController: UIViewController {

    @IBOutlet weak var usersSearchBar: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUIs()
    }
    
    func bindUIs() {
        usersSearchBar.rx.text
            .orEmpty
            .filter { searchText in
                return searchText.count > 2
            }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .map { searchText in
                let searchUserURL = URL.init(string: APIClient.Url.searchUser.rawValue + "?q=" + searchText.urlEncoded + "&sort=followers")!
                return searchUserURL
            }
            .flatMapLatest { request in
                return URLSession.shared.rx.json(url: request).catchErrorJustReturn([])
            }
            .map { json -> [GithubUser] in
                guard let _json = json as? [String: Any], let users = _json["items"] as? [[String: Any]] else {
                    return []
                }
                return users.flatMap { GithubUser.init(userObject: $0) }
            }
            .bind(to: usersTableView.rx.items) { tableView, row, user in
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")!
                cell.textLabel?.text = user.login
                cell.imageView?.kf.setImage(with: URL.init(string: user.avatarURL), placeholder: #imageLiteral(resourceName: "avatar"), options: nil, progressBlock: nil, completionHandler: nil)
                return cell
            }
            .disposed(by: disposeBag)
        
        
        usersSearchBar.rx.searchButtonClicked.subscribe({ (_) in
            self.usersSearchBar.resignFirstResponder()
        })
            .disposed(by: disposeBag)
        
    }
}
