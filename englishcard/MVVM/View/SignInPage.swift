//
//  SignInPage.swift
//  englishcard
//
//  Created by Ercan on 4.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInPage: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try! firebaseAuth.signOut()
        signInButton.setGradientLayer()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        email.setIcon(image: UIImage(systemName: "person.crop.circle")!)
        password.setIcon(image: UIImage(systemName: "lock.fill")!)
    }
    
    @IBAction func signIn(_ sender: Any) {
        guard let email = email.text else {return}
        guard let password = password.text else {return}
        
        firebaseAuth.signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            self.performSegue(withIdentifier: "toHomePage", sender: nil)
            
        }
    }
    

}
