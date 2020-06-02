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
            if let myError = error {
                self.showAlert(message: myError.localizedDescription)
                return
            }
            NotificationCenter.default.post(name: .changeIndex, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func showAlert(message : String){
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "OK", style: .destructive) { _ in}
        
        alertController.addAction(okeyAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}
