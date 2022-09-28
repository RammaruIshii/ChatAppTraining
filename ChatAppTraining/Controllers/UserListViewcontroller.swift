//
//  UserListViewcontroller.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/28.
//

import UIKit

class UserListViewcontroller: UIViewController {
    private let UserListcellId = "UserListcellId"
    
    @IBOutlet weak var userListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userListTableView.delegate = self
        userListTableView.dataSource = self
        //forCellReuseIdentifierでさっき作ったcellのIDを自動で作ってくれる
//        userListTableView.register(UITableViewCell.self, forCellReuseIdentifier: UserListcellId)
    }
}

extension UserListViewcontroller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTableView.dequeueReusableCell(withIdentifier: UserListcellId, for: indexPath)
        return cell
    }
}

class UserListTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
