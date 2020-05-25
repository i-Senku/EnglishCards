//
//  TabBarController.swift
//  englishcard
//
//  Created by Ercan on 25.05.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import FirebaseAuth
class TabBarController: UITabBarController , UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(tabBarController.selectedIndex)
        /*if tabBarController.selectedIndex == 2{
            print("Evet")
            let firebaseAuth = Auth.auth()
            
            if firebaseAuth.currentUser != nil {
            }else{
                let vc = storyboard?.instantiateViewController(withIdentifier: "signPage") as! SignInPage
                vc.modalPresentationStyle = .formSheet
                tabBarController.present(vc, animated: true, completion: nil)
            }
            
        }else{
        }*/
    }
}
