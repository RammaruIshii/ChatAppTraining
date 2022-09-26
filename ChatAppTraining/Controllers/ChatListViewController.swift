//
//  ChatListViewController.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/06.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class ChatListViewController: UIViewController {
    private let cellId = "cellId"
    
    @IBOutlet weak var chatListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .rgb(red: 19, green: 39, blue: 69)
        //タイトルの文字色変更
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "トーク"
        
        //起動時signUoVCをかぶせて出す
        let storyBord = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = storyBord.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.present(vc, animated: true, completion: nil)
        
        
        fetchUserInfoFromFireStore()
        
    }
    
    private func fetchUserInfoFromFireStore() {
        Firestore.firestore().collection("users").getDocuments { snapshots, error in
            if let error = error {
                print("user情報の取得に失敗しました。\(error)")
                return
            }
            
            //documentsは配列で来るからforEach
            snapshots?.documents.forEach({ snapshot in
                let data = snapshot.data()
                print("data: ",data)
            })
        }
    }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatListTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("タップされた")
        let storyBoard = UIStoryboard(name: "ChatRoom", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChatRoomViewController")
        navigationController?.pushViewController(vc, animated: true)
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
        userImageView.layer.cornerRadius = 29
    }

    //tableView呼ぶのに必要なもの
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
