//
//  ChatRoomViewController.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/07.
//

import UIKit

class ChatRoomViewController: UIViewController {
    private let cellId = "cellID"
    private var massages = [String]()
    
    //ChatInputAccesaryViewをインスタンスで作るため
    //ここの書き方
    //Lazyはview.delegate = selfのエラーを消すため
    private lazy var chatInputAccesaryView: ChatInputAccesaryView = {
        let view = ChatInputAccesaryView()
        view.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        
        //ChatInputAccesaryViewで記述したdelegateをChatInputAccesaryViewをインスタンス化したViewで採用する
        //ここのselfはChatRoomViewControllerのこと
        view.delegate = self
        return view
    }()
    
    @IBOutlet weak var chatRoomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        //cellの登録(ここ記述しないとprivate let cellId = "cellID"で定義したChatRoomTableViewCell表示できない)
        chatRoomTableView.register(UINib(nibName: "ChatRoomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        chatRoomTableView.backgroundColor = .rgb(red: 118, green: 140, blue: 180)
    }
    
    //ViewControllerには元々inputAccessoryViewというプロパティがあるため、その上にさっきのchatInputAccesaryViewをセットする.
    //inputAccessoryViewはセットしたViewなどキーボードと一緒に上がったり下がったり簡単に実装できるためおすすめ
    override var inputAccessoryView: UIView? {
        get {
            return chatInputAccesaryView
        }
    }
    //上記とセットで記述
    override var canBecomeFirstResponder: Bool{
        return true
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
        return massages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        //chatRoomTableViewへアクセス
        let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatRoomTableViewCell
        
        cell.messageTextView.text = massages[indexPath.row]

        return cell
    }
    
    //cellの高さを定義するメソッド
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        chatRoomTableView.estimatedRowHeight = 20
        return UITableView.automaticDimension
    }
}

extension ChatRoomViewController: ChatInputAccesaryViewDeleate {
    func tappedSendButton(text: String) {
        //送られてきたメッセージをappendで入れてあげる
        massages.append(text)
        //textViewに入力された情報をボタンを押すと消去
//        chatInputAccesaryView.chatTextView.text = ""
        
        //textViewに入力された情報をボタンを押すと消去・空だとボタンが使えない
        chatInputAccesaryView.removeText()
        
        //textViewに入力された情報をCellとして表示させる
        chatRoomTableView.reloadData()

        print(text)
    }
    
    
}
