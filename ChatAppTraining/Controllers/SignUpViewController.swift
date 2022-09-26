//
//  SignUpViewController.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/21.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class SignUpViewController: UIViewController {
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var alreadyHaveAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //コードでIBAction練習
        registerButton.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        
        profileImageButton.layer.cornerRadius = 85
        //縁の色
        profileImageButton.layer.borderWidth = 1
        //UIColorをextensionで拡張させたもの
        profileImageButton.layer.borderColor = UIColor.rgb(red: 240, green: 240, blue: 240).cgColor
        
        registerButton.layer.cornerRadius = 15
        
        //Textfieldの値を渡すためにDelegate
        emailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
        //ボタンの初期状態は使えない
        registerButton.isEnabled = false
        registerButton.backgroundColor = .rgb(red: 100, green: 100, blue: 100)
        
    }
    
    @IBAction func tappedProfileImageButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //コードでIBAction練習
    //FireStoregeへプロフィール画像を保存する処理
    @objc private func tappedRegisterButton() {
        guard let image = profileImageButton.imageView?.image else { return }
        //画像データをJpegに変えて画像をデフォルトの状態で貼らないように0.3に設定
        guard let uploadImage = image.jpegData(compressionQuality: 0.3) else { return }
        
        //今回はファイルネームをこちらで任意に作って保存する
        //生成される毎に変わる文字列
        //クライアントからサーバにリクエストする際、任意のIDが必要となる場合など
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_image").child(fileName)
        storageRef.putData(uploadImage) { metadata, error in
            if let error = error {
                print("FireStorageへの情報の保存に失敗しました。\(error)")
                return
            }
            
//            print("FireStorageへの情報の保存に成功しました。")
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("FireStorageからのダウンロードに失敗しました。\(error)")
                    return
                }
                
                //urlをstringに変換
                guard let urlString = url?.absoluteString else { return }
                print("urlString:",urlString)
                //取得した画像のURL情報をcreateUserToFirestore(profileImageUrl: String)へ渡す
                self.createUserToFirestore(profileImageUrl: urlString)
            }
        }

    }
    
    //FireStoredへ認証が通過したユーザー情報を保存
    //加えて、取得した画像のURLの情報を受け取るために引数にprofileImageUrlをセット
    private func createUserToFirestore(profileImageUrl: String) {
        //email,passwordをAuthに保存
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("認証に失敗しました")
                return
            }
//            print("認証に成功しました")
            
            //firestore(データベース)に保存できるように記述
            guard let uid = authResult?.user.uid else { return }
            
            //setDateへ渡す変数（辞書型という決まり）
            let dogData = [
                "email": email,
                "username": username,
                //作成した日時
                "createdAt": Timestamp(),
                //取得した画像URL
                "profileImageUrl": profileImageUrl
            ]
            
            //uidを記述
            Firestore.firestore().collection("users").document(uid).setData(dogData) {(error) in
                if let error = error {
                    print("データベースへ情報の保存に失敗しました.\(error)")
                    return
                }
                print("データベースへ情報の保存に成功しました。")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    //ここでTextFieldの値を受け取る
    func textFieldDidChangeSelection(_ textField: UITextField) {
        //各TextFieldがnil(空白)だったらfalseを返す == 実質false
        let emailIsEmpty = emailTextField.text?.isEmpty ?? false
        let passwordIsEmpty = passwordTextField.text?.isEmpty ?? false
        let usernameIsEmpty = usernameTextField.text?.isEmpty ?? false
        
        if emailIsEmpty || passwordIsEmpty || usernameIsEmpty {
            registerButton.isEnabled = false
            registerButton.backgroundColor = .rgb(red: 100, green: 100, blue: 100)
            //全てのTextFieldに値が入っていたら
        } else {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .rgb(red: 100, green: 185, blue: 100)
        }
        
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //editedImageは大きさとか高さ変えた写真を受け取る
        if let editImage = info[.editedImage] as? UIImage {
            profileImageButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
            //originalImageは何も変更を加えないそのままの写真を受け取る
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        profileImageButton.setTitle("", for: .normal)
        //当該ボタン内に画像を収める
        profileImageButton.imageView?.contentMode = .scaleAspectFit
        //UIButtonのサイズまで拡大する
        profileImageButton.contentHorizontalAlignment = .fill
        profileImageButton.contentVerticalAlignment = .fill
        //当該ボタン内(領域内)に画像を収める
        profileImageButton.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
    
}
