//
//  ChatRoomViewController.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/07.
//

import UIKit

class ChatRoomViewController: UIViewController {
    private let cellId = "cellID"
    
    @IBOutlet weak var chatRoomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        //cellの登録(ここ記述しないとprivate let cellId = "cellID"で定義したChatRoomTableViewCell表示できない)
        chatRoomTableView.register(UINib(nibName: "ChatRoomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        chatRoomTableView.backgroundColor = .rgb(red: 118, green: 140, blue: 180)
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//        cell.backgroundColor = .purple
        return cell
    }
    
    //cellの高さを定義するメソッド
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        chatRoomTableView.estimatedRowHeight = 20
        return UITableView.automaticDimension
    }
    
}
