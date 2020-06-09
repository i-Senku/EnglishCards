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
    
    var isSelectTable = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientLayer()
    }
    
    @IBAction func selectLanguage(_ sender: Any) {
        if isSelectTable {
            performSegue(withIdentifier: "toHomefromLanguage", sender: nil)
        }
    }
    
}

extension LanguagesPage : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectLanguageVM.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let countryName = SelectLanguageVM.languages[indexPath.row].languageName
        let countryImage = SelectLanguageVM.languages[indexPath.row].languageImage
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "languages", for: indexPath) as! Languages
        cell.countryName.text = countryName
        cell.flagImage.image = UIImage(named: countryImage)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.countryList.cellForRow(at: indexPath)?.accessoryType = .checkmark
        isSelectTable = true
        
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        

            if let selectedIndex = self.countryList.indexPathForSelectedRow {
                self.countryList.deselectRow(at: selectedIndex, animated: true)
                self.countryList.cellForRow(at: selectedIndex)?.accessoryType = .none
            }
                
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return countryList.bounds.size.height * 0.32
    }
    
    
}

