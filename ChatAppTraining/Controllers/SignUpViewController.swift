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

}
