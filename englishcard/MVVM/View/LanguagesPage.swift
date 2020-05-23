//
//  LanguagesPage.swift
//  englishcard
//
//  Created by Ercan on 10.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

class LanguagesPage: UIViewController {

    @IBOutlet weak var countryList: UITableView!
    
    @IBOutlet weak var learnLanguage: UITableView!
    
    
    let languagesVM = SelectLanguageVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientLayer()
    }
}

extension LanguagesPage : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languagesVM.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let countryName = languagesVM.languages[indexPath.row].languageName
        let countryImage = languagesVM.languages[indexPath.row].languageImage
        
        if tableView == learnLanguage {
            let cell = tableView.dequeueReusableCell(withIdentifier: "learnlanguages", for: indexPath) as! Languages
            cell.countryName.text = countryName
            cell.flagImage.image = UIImage(named: countryImage)
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "languages", for: indexPath) as! Languages
            cell.countryName.text = countryName
            cell.flagImage.image = UIImage(named: countryImage)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == learnLanguage {
            self.learnLanguage.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }else{
            self.countryList.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if tableView == learnLanguage {
            if let selectedIndex = self.learnLanguage.indexPathForSelectedRow {
                self.learnLanguage.deselectRow(at: selectedIndex, animated: true)
                self.learnLanguage.cellForRow(at: selectedIndex)?.accessoryType = .none
            }
        }else{
            if let selectedIndex = self.countryList.indexPathForSelectedRow {
                self.countryList.deselectRow(at: selectedIndex, animated: true)
                self.countryList.cellForRow(at: selectedIndex)?.accessoryType = .none
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return countryList.bounds.size.height * 0.32
    }
    
}

