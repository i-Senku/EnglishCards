//
//  SettingsPage.swift
//  englishcard
//
//  Created by Ercan on 7.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

class SettingsPage: UIViewController{


    @IBOutlet weak var settingsList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SettingsPage : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cellfirst = tableView.dequeueReusableCell(withIdentifier: "settings1", for: indexPath) as! SettingsFirst
            cellfirst.settingName.text = "Language"
            return cellfirst
        }else{
            let cellSecond = tableView.dequeueReusableCell(withIdentifier: "settings2", for: indexPath) as! Settings
            cellSecond.settingName.text = "Sounds"
            return cellSecond
        }
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        let title = UILabel()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = headerSection[section]
        title.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        
        
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10)
        ])
        return view
    }*/
    
}
