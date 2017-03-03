//
//  AlarmTimePickerViewController.swift
//  DoNothing
//
//  Created by 棚瀬 隆太 on 2017/03/03.
//  Copyright © 2017年 棚瀬 隆太. All rights reserved.
//

import UIKit

protocol AlarmTimePickerViewControllerDelegate: class {
    func tappedDoneButton(time: String)
    func tappedCancelButton()
}

class AlarmTimePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerBackgroundView: UIView!
    @IBOutlet weak var toolBarView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    weak var delegate: AlarmTimePickerViewControllerDelegate?
    
    class func view() -> AlarmTimePickerViewController? {
        return UIStoryboard(name: "AlarmTimePickerViewController", bundle: nil).instantiateInitialViewController() as? AlarmTimePickerViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cancelButton.layer.cornerRadius = 5
        doneButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedBackgroundView() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedDoneButton(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "HH:mm"
        dismiss(animated: true, completion: nil)
        delegate?.tappedDoneButton(time: dateFormatter.string(from: datePicker.date))
    }
    
    @IBAction func tappedCancelButton(_ sender: UIButton) {
        tappedBackgroundView()
    }

}
