//
//  SettingsFirst.swift
//  englishcard
//
//  Created by Ercan on 27.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

protocol SettingsFirstDelegate : AnyObject {
    func showPicker()
    func showPrivacy()
}

class SettingsFirst: UITableViewCell {

    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var settingName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    weak var delegate : SettingsFirstDelegate?
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func showAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            delegate?.showPicker()
        case 1 :
            delegate?.showPrivacy()
        default:
            print("Geçersiz")
        }
        
    }
}
