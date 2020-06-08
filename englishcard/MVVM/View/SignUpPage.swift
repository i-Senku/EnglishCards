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
        guard let aprovePassword = aprovePassword.text else {return}
        guard let userName = username.text else {return}
        
        if aprovePassword != password {
            showAlert(message: "Passwords must be the same")
        }else{
            
            
            firebaseAuth.createUser(withEmail: email, password: password) { (authResult, error) in
                if let myError = error {
                    self.showAlert(message: myError.localizedDescription)
                    return
                }
                let request = authResult?.user.createProfileChangeRequest()
                request?.displayName = userName
                request?.commitChanges(completion: { (error) in
                    if error == nil {
                    print("Kayıt oldu")
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                })
            }
        }
    }
    
    fileprivate func showAlert(message : String){
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "OK", style: .destructive) { _ in}
        
        alertController.addAction(okeyAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}
