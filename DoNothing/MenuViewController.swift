//
//  MenuViewController.swift
//  DoNothing
//
//  Created by 棚瀬 隆太 on 2017/03/02.
//  Copyright © 2017年 棚瀬 隆太. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
    func tappedDone()
}

enum MenuList {
    case alert
    case section
    case row
    
    func toSection() -> Int {
        return self.hashValue
    }
    
    static let count = 3
}

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: MenuViewControllerDelegate?
    
    var currentSettingTime = "10:00"
    var alarmIsOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchIsSetAlarm()
        fetchAlarmSetTime()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchAlarmSetTime() {
        guard let setTime = UserDefaults.sharedInstance.fetchAlarmTime() else {
            return
        }
        currentSettingTime = setTime
    }
    
    func fetchIsSetAlarm() {
        guard let isSetAlarm = UserDefaults.sharedInstance.fetchIsSetAlarm() else {
            return
        }
        alarmIsOn = isSetAlarm
    }
    
    @IBAction func tappedDone(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        UserDefaults.sharedInstance.saveAlarmTime(time: currentSettingTime)
        UserDefaults.sharedInstance.saveIsSetAlarm(isOn: alarmIsOn)
        delegate?.tappedDone()
    }

}

extension MenuViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case MenuList.alert.toSection():
            return 193
        case MenuList.section.toSection():
            return 60
        case MenuList.row.toSection():
            return 54
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case MenuList.alert.toSection():
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlermSettingCell") as! AlermSettingCell
            cell.selectionStyle = .none
            cell.updateCell(time: currentSettingTime)
            cell.delegate = self
            return cell
        case MenuList.section.toSection():
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionViewCell") as! SectionViewCell
            cell.selectionStyle = .none
            return cell
        case MenuList.row.toSection():
            let cell = tableView.dequeueReusableCell(withIdentifier: "RowViewCell") as! RowViewCell
            cell.selectionStyle = .none
            
            switch indexPath.row {
            case RowViewCellRows.lastTapCount.toRow():
                cell.updateCell(title: RowViewCellRows.lastTapCount.toTitle(), value: "\(UserDefaults.sharedInstance.fetchLastTapCount() ?? 0)回")
            case RowViewCellRows.totalTapCount.toRow():
                cell.updateCell(title: RowViewCellRows.totalTapCount.toTitle(), value: "\(UserDefaults.sharedInstance.fetchTotalTap() ?? 0)回")
            case RowViewCellRows.fastestTapTime.toRow():
                var strTime = "--"
                if let time = UserDefaults.sharedInstance.fetchFastestTapTime() {
                    strTime = String(format: "%.2f", Double(time))
                }
                cell.updateCell(title: RowViewCellRows.fastestTapTime.toTitle(), value: "\(strTime)秒")
            case RowViewCellRows.latestTapTime.toRow():
                var strTime = "--"
                if let time = UserDefaults.sharedInstance.fetchLatestTapTime() {
                    strTime = String(format: "%.2f", Double(time))
                }
                cell.updateCell(title: RowViewCellRows.latestTapTime.toTitle(), value: "\(strTime)秒")
            default:
                cell.updateCell(title: "--", value: "--")
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case MenuList.alert.toSection():
            return 1
        case MenuList.section.toSection():
            return 1
        case MenuList.row.toSection():
            return RowViewCellRows.count
        default:
            return 0
        }
    }
}

extension MenuViewController: AlermSettingCellDelegate {
    func tappedEditButton() {
        guard let vc = AlarmTimePickerViewController.view() else {
            return
        }
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func tappedSwitch(isOn: Bool) {
        alarmIsOn = isOn
    }
}

extension MenuViewController: AlarmTimePickerViewControllerDelegate {
    func tappedDoneButton(time: String) {
        currentSettingTime = time
        tableView.reloadData()
    }
    
    func tappedCancelButton() {
        
    }
}
