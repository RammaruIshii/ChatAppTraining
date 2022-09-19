//
//  ChatRoomTableViewCell.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/08.
//

import UIKit

class ChatRoomTableViewCell: UITableViewCell {
    
    //messageTextViewではなく、やっぱりこっちでText情報を受け取る
    var messageText: String? {
        didSet {
            guard let text = messageText else { return }
            
            messageTextView.text = text
            
            let width = estimateFrameFortextView(text: text).width + 20
            
//            let hight = estimateFrameFortextView(text: text).height
            
            messageTextViewWidthConstraint.constant = width
            
//            messageTextViewHightConstraint.constant = hight
            
        }
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

//    @IBOutlet weak var messageTextViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextViewWidthConstraint: NSLayoutConstraint!
    
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
    
    //文字数などによってtextViewの幅を決める関数(以下はこういうものだと認識)
    private func estimateFrameFortextView(text: String) -> CGRect {
        //Max値
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], context: nil)
    }
    
}
