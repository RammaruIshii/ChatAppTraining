//
//  User.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/26.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

//これenumでも良いのでは？
class User {
    
    let username: String
    let email: String
    let profileImageUrl: String
    let createdAt: Timestamp
    
    var uid: String?
    
    //コンソール情報を見るとdictionaryになっているため
    //[String: Any]で一つの型、そのため、Stringをキーにしてデータはどんな型でも入れられる
    init(dic: [String: Any]) {
        //今回のSelf.usernameは予めString型と定義されているので例としては分かりにくいが、本来、変数usernameなどがあった場合、usernameはAny型なので、使うときに何かしらにキャストする必要がある
        //今回でいうex) var username = dic["username"] as? String ?? "" みたいな感じ
        self.username = dic["username"] as? String ?? ""
        self.email = dic["email"] as? String ?? ""
        self.profileImageUrl = dic["profileImageUrl"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
    
}
