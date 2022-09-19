//
//  ChatInpuAccesaryView.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/08.
//

import UIKit

//現在、textの中に入力された文字列（値）などはChatInputAccesaryViewの中に保持されている。そこで、この値はChatRomViewのtableViewの中に値を渡したい。そのため、delegateを使ってChatRomViewのtableViewに値を渡す。
//この型のclassはメモリリークを防ぐためのもの（こういうもの）
protocol ChatInputAccesaryViewDeleate: class {
    func tappedSendButton(text: String)
}

class ChatInputAccesaryView: UIView {
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    //メモリーリークを防ぐため
    weak var delegate: ChatInputAccesaryViewDeleate?
    
//    カスタムUIViewやUIButtonを作成した時に、initメソッド内で定数や配列の初期化などを行いたい
//初期化というのは何か値を与えること
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibInit()
        setUpViews()
        //テキストビューの大きさとビューの大きさが自動的に変わる
        autoresizingMask = .flexibleHeight
    }
    
    //textView可変にする方法
    //下記記述
    //scrolllingのscrolling Enabledのチェックマーク外す
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    private func setUpViews() {
        chatTextView.layer.cornerRadius = 15
        //borderColor定義するときは最後に.cgColor定義
        chatTextView.layer.borderColor = UIColor.rgb(red: 230, green: 230, blue: 230).cgColor
        chatTextView.layer.borderWidth = 1
        
        sendButton.layer.cornerRadius = 15
        sendButton.imageView?.contentMode = .scaleAspectFill
        sendButton.contentHorizontalAlignment = .fill
        sendButton.contentVerticalAlignment = .fill
        //初期状態は使えないようにしておきたい
        sendButton.isEnabled = false
        
        chatTextView.text = ""
        //chatTextViewが入力されたか否かを監視したいためdelegateを定義
        chatTextView.delegate = self
    }

    //カスタムビューの作り方。カスタムビューを作ることでUIを使い回すことができる。（xibのファイルをこのViewの上にセットしたいため記述）
    private func nibInit() {
        let nib = UINib(nibName: "ChatInputAccesaryViewCell", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        
        view.frame = self.bounds
        //UIViewがサイズ変更、向きの変更、テーブルビューセルでの編集コントロールの表示などによってスーパービューが変更されたときに、適切にシフトおよびサイズ変更することです。
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }
    
    //chatRoomにてメッセージの表示とテキストの文字を消去する関数
    func removeText() {
        chatTextView.text = ""
        sendButton.isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func tappedChatButton(_ sender: Any) {
        guard let text = chatTextView.text else { return }
        delegate?.tappedSendButton(text: text)
    }
    
}

extension ChatInputAccesaryView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
//        print("押せてる")
        if textView.text.isEmpty {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
    }
}
