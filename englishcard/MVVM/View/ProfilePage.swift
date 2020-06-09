//
//  ProfilePage.swift
//  englishcard
//
//  Created by Ercan on 27.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ProfilePage: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    let managedContext = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var profilImage: UIImageView!
    
    let firebaseAuth = Auth.auth()
    var favoriteListe : [Favorites] = [Favorites]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(updateTableViewWithNotification), name: .updateCoreData, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItem()
        if let currentUser = firebaseAuth.currentUser {
            userName.text = currentUser.displayName
            email.text = currentUser.email
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try firebaseAuth.signOut()
            NotificationCenter.default.post(name: Notification.Name(rawValue: "changeIndex"), object: nil)

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func updateTableViewWithNotification(){
        fetchItem()
    }
    
    func fetchItem(){
        
        let fetchRequest:NSFetchRequest<Favorites> = Favorites.fetchRequest()
        
        do {
            favoriteListe = try managedContext.fetch(fetchRequest)
            self.tableView.reloadData()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

extension ProfilePage : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row+1) - \(favoriteListe[indexPath.row].wordName!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = favoriteListe.remove(at: indexPath.row)
            managedContext.delete(item)
            do {
                try managedContext.save()
                tableView.reloadData()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
