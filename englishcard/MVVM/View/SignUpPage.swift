//
//  SignUpPage.swift
//  englishcard
//
//  Created by Ercan on 6.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpPage: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var aprovePassword: UITextField!
    let firebaseAuth = Auth.auth()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        username.setIcon(image: UIImage(systemName: "person.crop.circle")!)
        email.setIcon(image: UIImage(systemName: "envelope.fill")!)
        password.setIcon(image: UIImage(systemName: "lock.fill")!)
        aprovePassword.setIcon(image: UIImage(systemName: "lock.fill")!)

    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard let email = email.text else {return}
        guard let password = password.text else {return}
        
        firebaseAuth.createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
        }
    }
    

}
