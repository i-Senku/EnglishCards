//
//  SettingsPage.swift
//  englishcard
//
//  Created by Ercan on 7.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

class SettingsPage: UIViewController{
    
    

    @IBOutlet weak var pickerBar: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var settingsList: UITableView!
    @IBOutlet weak var heightPickerView: NSLayoutConstraint!
    
    let defaults = UserDefaults.standard
    
    
    let SettingsFirstList = ["Languages","Privacy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func donePicker(_ sender: Any) {
        heightPickerView.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.pickerBar.alpha = 0
            self.view.layoutIfNeeded()
        }
        let selectedLanguage = SelectLanguageVM.languages[pickerView.selectedRow(inComponent: 0)].languageName.lowercased()
        UserDefaults.standard.set(selectedLanguage, forKey: "mainlanguage")
    }
    
}

extension SettingsPage : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cellfirst = tableView.dequeueReusableCell(withIdentifier: "settings1", for: indexPath) as! SettingsFirst
            cellfirst.settingName.text = SettingsFirstList[indexPath.row]
            cellfirst.delegate = self
            cellfirst.selectedButton.tag = indexPath.row
            return cellfirst
        }else{
            let cellSecond = tableView.dequeueReusableCell(withIdentifier: "settings2", for: indexPath) as! Settings
            cellSecond.settingName.text = "Sounds"
            if defaults.bool(forKey: "sound") {
                cellSecond.soundSwitch.isOn = true
            }else{
                cellSecond.soundSwitch.isOn = false
            }
            return cellSecond
        }
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension SettingsPage : SettingsFirstDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SelectLanguageVM.languages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SelectLanguageVM.languages[row].languageName
    }
    
    
    func showPicker() {
        heightPickerView.constant = 200
        UIView.animate(withDuration: 0.5) {
            self.pickerBar.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    func showPrivacy() {
        print("Privacy")
    }
    
    
}
