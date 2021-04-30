//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Tiffany Sakaguchi on 4/29/21.
//

import UIKit

//MARK: - Protocol

protocol AlarmTableViewCellDelegate: AnyObject {
    func alarmWasToggled(sender: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: - Properties
    
    weak var delegate: AlarmTableViewCellDelegate?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateViews(alarm: Alarm) {
        alarmTitleLabel.text = alarm.title
        alarmFireDateLabel.text = DateFormatter.fireDate.string(from: alarm.fireDate ?? Date())
        isEnabledSwitch.isOn = alarm.isEnabled
    }
    
    @IBAction func itEnabledSwitchToggled(_ sender: UISwitch) {
        delegate?.alarmWasToggled(sender: self)
    }
    
}//End of class
