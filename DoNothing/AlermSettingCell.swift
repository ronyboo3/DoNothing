//
//  AlermSettingCell.swift
//  DoNothing
//
//  Created by 棚瀬 隆太 on 2017/03/02.
//  Copyright © 2017年 棚瀬 隆太. All rights reserved.
//

import UIKit

protocol AlermSettingCellDelegate: class {
    func tappedEditButton()
    func tappedSwitch(isOn: Bool)
}

class AlermSettingCell: UITableViewCell {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mainSwitch: UISwitch!
    @IBOutlet weak var sectionBackgroundView: UIView!
    
    weak var delegate: AlermSettingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sectionBackgroundView.layer.shadowOffset = CGSize(width: 1.6, height: 1.6)
        sectionBackgroundView.layer.shadowOpacity = 0.5
        editButton.layer.cornerRadius = 5
        
        if let alarmIsOn = UserDefaults.sharedInstance.fetchIsSetAlarm() {
            mainSwitch.isOn = alarmIsOn
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(time: String) {
        updateAlermArea()
        timeLabel.text = time
    }
    
    func updateAlermArea() {
        if mainSwitch.isOn {
            timeLabel.textColor = UIColor.white
            editButton.backgroundColor = UIColor.white
            editButton.titleLabel?.textColor = UIColor.black
            editButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
            editButton.layer.shadowOpacity = 0.3
            editButton.isEnabled = true
        } else {
            timeLabel.textColor = UIColor.lightGray
            editButton.backgroundColor = UIColor.lightText
            editButton.titleLabel?.textColor = UIColor.lightGray
            editButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            editButton.layer.shadowOpacity = 0.0
            editButton.isEnabled = false
        }
    }
    
    @IBAction func tappedSwitch(sender: UISwitch) {
        updateAlermArea()
        delegate?.tappedSwitch(isOn: sender.isOn)
    }
    
    @IBAction func tappedEditButton(sender: UIButton) {
        delegate?.tappedEditButton()
    }
    
}
