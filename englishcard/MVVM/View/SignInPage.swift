//
//  SignInPage.swift
//  englishcard
//
//  Created by Ercan on 4.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

class SignInPage: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.setGradientLayer()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        email.setIcon(image: UIImage(systemName: "person.crop.circle")!)
        password.setIcon(image: UIImage(systemName: "lock.fill")!)

    }

}
