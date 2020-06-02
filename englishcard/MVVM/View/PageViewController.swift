//
//  PageViewController.swift
//  englishcard
//
//  Created by Ercan on 26.05.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import FirebaseAuth

class PageViewController: UIPageViewController{
    
     lazy var subViewController : [UIViewController] = {
       return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profile"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signPage")
        ]
    }()
    
    let fireBaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if fireBaseAuth.currentUser != nil {
            setViewControllers([subViewController[0]], direction: .forward, animated: true, completion: nil)
        }else{
            setViewControllers([subViewController[1]], direction: .forward, animated: true, completion: nil)

        }
    }
    
    

}
