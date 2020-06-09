//
//  Settings.swift
//  englishcard
//
//  Created by Ercan on 27.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit



class Settings: UITableViewCell {
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var settingName: UILabel!
    let defaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print(defaults.bool(forKey: "sound"))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func soundSwitch(_ sender: UISwitch) {
        print(sender.isOn)
        defaults.set(sender.isOn, forKey: "sound")
        
        print("Değeri : \(defaults.bool(forKey: "sound"))")
    }
}
