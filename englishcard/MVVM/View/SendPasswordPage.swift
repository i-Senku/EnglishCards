//
//  SendPasswordPage.swift
//  englishcard
//
//  Created by Ercan on 7.06.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import FirebaseAuth

class SendPasswordPage: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    let auth = Auth.auth()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendButton.setGradientLayer()
        sendButton.layer.cornerRadius = 15
    }
    
    @IBAction func send(_ sender: Any) {
        guard let mail = textField.text else {return}
        
        auth.sendPasswordReset(withEmail: mail) { (error) in
            if error != nil {
                self.showAlert(title: "Error", message: error!.localizedDescription)
            }else{
                self.showAlert(title: "Succesfuly", message: "Please check your email address")
            }
            
        }
        
        
        
    }
    
    @IBAction func closePage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionOkey = UIAlertAction(title: "Okay", style: .default) { (_) in
        }
        alert.addAction(actionOkey)
        
        present(alert, animated: true, completion: nil)
    }
}
