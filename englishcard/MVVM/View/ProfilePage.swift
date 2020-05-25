//
//  ProfilePage.swift
//  englishcard
//
//  Created by Ercan on 27.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfilePage: UIViewController {
    
    
    @IBOutlet weak var userName: UILabel!
    
    let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if firebaseAuth.currentUser != nil {
            userName.text = firebaseAuth.currentUser?.email
        }else{
            userName.text = "NaN"
        }

    }

    @IBAction func click(_ sender: Any) {
        try! firebaseAuth.signOut()
    }
}
