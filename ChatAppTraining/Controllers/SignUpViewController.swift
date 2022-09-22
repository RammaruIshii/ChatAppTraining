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
    @objc private func tappedRegisterButton() {
        //email,passwordをAuthに保存
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("認証に失敗しました")
                return
            }
            print("認証に成功しました")
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
