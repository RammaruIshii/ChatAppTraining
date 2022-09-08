//
//  ChatRoomTableViewCell.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/08.
//

import UIKit

class ChatRoomTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //このcellの背景を透明にしてChatromVCの背景を表示させる
        self.backgroundColor = .clear
        userImageView.layer.cornerRadius = 44
        messageTextView.layer.cornerRadius = 15
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
