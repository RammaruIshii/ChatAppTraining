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
    //fetchLoginUserInfoメソッドより、このuserに情報がセットされた時点でナヴィゲーションバーのタイトルをセットしたい
    private var user: User? {
        didSet {
            navigationItem.title = user?.username
        }
    }
    
    
    @IBOutlet weak var chatListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        //ログイン情報が端末に無い場合にアプリ起動時signupVCを表示
        confirmLoggedInUser()
        //現在ログインしているユーザー情報
        fetchLoginUserInfo()
        
        //ここに記述するとfirestoreへ情報の保存に成功した際、コンソール画面にて成功文言の上にコンソール内容が書かれてしまうため見にくいがここでreloadDataしなければcellが無限に増えてしまうため妥協
//        fetchUserInfoFromFireStore()
        
    }
    
    @objc private func tappedNavRightBarButton() {
        let storyBoard = UIStoryboard.init(name: "UserList", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserListViewcontroller")
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    private func setUpViews() {
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
        
        let rightBarButton = UIBarButtonItem(title: "新規チャット", style: .plain, target: self, action: #selector(tappedNavRightBarButton))
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    //ログイン情報が端末に無い場合にアプリ起動時signupVCを表示
    private func confirmLoggedInUser() {
        if Auth.auth().currentUser?.uid == nil {
            //起動時signUoVCをかぶせて出す
            let storyBord = UIStoryboard(name: "SignUp", bundle: nil)
            let vc = storyBord.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //現在ログインしているユーザーの情報を取得
    private func fetchLoginUserInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //document(今ログインしている該当のユーザーを引っ張ってこれる)
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("ユーザー情報の取得に失敗しました\(error)")
            }
            guard let snapshot = snapshot else { return }
            guard let dic = snapshot.data() else { return }
            let user = User(dic: dic)
            self.user = user
        }
    }
    
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
//        return users.count
//        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //ChatlisttableVCellへアクセス
        //ここでユーザーの情報を渡す
        let cell = chatListTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatListTableViewCell
//        cell.user = users[indexPath.row]
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
    //未完成
    var user: User? {
        didSet {
            //userの中でnilチェックなためuserと入力する
            if let user = user {
                userNameLabel.text = user.username
                massageLabel.text = user.email
                //これだとうまく表示されない
    //            dateLabel.text = user?.createdAt.dateValue().description
                dateLabel.text = dateFormatterForDataLabel(date: user.createdAt.dateValue())
                //次回
//                userImageView.image = user.profileImageUrl
            }
        }
    }
    
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
    
    //時間の扱いはデートフォーマッターを使う
    private func dateFormatterForDataLabel(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ja_JP")
        //Date型をString型にキャストするよう返している
        return formatter.string(from: date)
        
    }
    
}
