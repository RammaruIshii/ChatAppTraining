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
    
    let username: String?
    let email: String?
    let profileImageUrl: String?
    let createdAt: Timestamp?
    
    //コンソール情報を見るとdictionaryになっているため
    init(dic: [String: Any]) {
        self.username = dic["username"] as? String ?? ""
        self.email = dic["email"] as? String ?? ""
        self.profileImageUrl = dic["profileImageUrl"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
    
}
