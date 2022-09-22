//
//  SignUpViewController.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/21.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var alreadyHaveAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageButton.layer.cornerRadius = 85
        //縁の色
        profileImageButton.layer.borderWidth = 1
        //UIColorをextensionで拡張させたもの
        profileImageButton.layer.borderColor = UIColor.rgb(red: 240, green: 240, blue: 240).cgColor
        
        registerButton.layer.cornerRadius = 15
    }
    
    @IBAction func tappedProfileImageButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
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
