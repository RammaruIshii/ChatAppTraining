//
//  UserListViewcontroller.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/28.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import Nuke

class UserListViewcontroller: UIViewController {
    private let UserListcellId = "UserListcellId"
    //この書き方調べる
    private var users = [User]()
    
    private var selectedUser: User?
    
    @IBOutlet weak var userListTableView: UITableView!
    @IBOutlet weak var startChatButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userListTableView.delegate = self
        userListTableView.dataSource = self
        
        startChatButton.layer.cornerRadius = 10
        startChatButton.isEnabled = false
        startChatButton.addTarget(self, action: #selector(tappedStartChatButton), for: .touchUpInside)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .rgb(red: 39, green: 49, blue: 69)
        //タイトルの文字色変更
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        //firestoreから読み取り、usersに保存し、リロードする処理
        fetchUserInfoFromFireStore()
        
        //forCellReuseIdentifierでさっき作ったcellのIDを自動で作ってくれる
//        userListTableView.register(UITableViewCell.self, forCellReuseIdentifier: UserListcellId)
    }
    
    private func fetchUserInfoFromFireStore() {
        Firestore.firestore().collection("users").getDocuments { snapshots, error in
            if let error = error {
                print("user情報の取得に失敗しました。\(error)")
                return
            }
            
            //documentsは配列で来るからforEach
            snapshots?.documents.forEach({ snapshot in
                //dataをuserに変える
//                let data = snapshot.data()
                let dic = snapshot.data()
                let user = User.init(dic: dic)
                
                //今ログインしているユーザーの情報を表示したくない
                guard let uid = Auth.auth().currentUser?.uid else { return }
                if uid == snapshot.documentID {
                    return
                }
                
                //ここでself.usersにモデルUserの情報を保存している(端末にっていうことか？)
                self.users.append(user)
//                tableviewはreloaddataしなければcellが表示されない
                self.userListTableView.reloadData()
                
//                実際にUserに保存できているか確認(端末にっていうことか？)
//                self.users.forEach({ user in
//                    print(user.username)
//                })
                
//                print("data: ",data)

            })
        }
    }
    
    @objc func tappedStartChatButton() {
        print("tappedStartChatButton")
        
    }
    
}

extension UserListViewcontroller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTableView.dequeueReusableCell(withIdentifier: UserListcellId, for: indexPath) as! UserListTableViewCell
        cell.user = users[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        startChatButton.isEnabled = true
        let user = users[indexPath.row]
        //rowを選択して引っ張ってきた情報（ユーザー）をselectedUserに入れる
        self.selectedUser = user
    }
}

class UserListTableViewCell: UITableViewCell {
    //FireStoreから取得した情報をcellに渡す
    var user: User? {
        didSet {
            self.userListLabel.text = user?.username
            //NukeはURLから読み込みをするためURLから作る
            //URLをStringから作る
            if let url = URL(string: user?.profileImageUrl ?? "") {
                Nuke.loadImage(with: url, into: userListImageView)
            }
        }
    }
    @IBOutlet weak var userListImageView: UIImageView!
    @IBOutlet weak var userListLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userListImageView.layer.cornerRadius = 25
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
