//
//  TabBarController.swift
//  englishcard
//
//  Created by Ercan on 25.05.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import FirebaseAuth

extension Notification.Name {
    static let changeIndex = Notification.Name(rawValue: "changeIndex")
}

class TabBarController: UITabBarController , UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let notification : NotificationCenter = NotificationCenter.default
        notification.addObserver(self, selector: #selector(changeIndex), name: .changeIndex, object: nil)
        
    }
    
    @objc func changeIndex(){
        selectedIndex = 0
    }

}
