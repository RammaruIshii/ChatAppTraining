//
//  ChatListViewController.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/06.
//

import UIKit

class ChatListViewController: UIViewController {
    @IBOutlet weak var chatListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

class ChatListTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var massageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //cell呼ぶのに必要なもの
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = 37
    }

    //tableView呼ぶのに必要なもの
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
