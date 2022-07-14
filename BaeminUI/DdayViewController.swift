//
//  DdayViewController.swift
//  BaeminUI
//
//  Created by SeungYeon Yoo on 2022/07/14.
//

import UIKit

class DdayViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
  
    @IBOutlet var imageViewCollection: [UIImageView]!

    @IBOutlet var DdayLabelCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        cornerChange()
    }
    
    private func configureUI() {
           setAttributes()
       }
       
       private func setAttributes() {
           if #available(iOS 14.0, *) {
               // iOS 14 이상
               datePicker.preferredDatePickerStyle = .inline
           } else {
               // iOS 14 미만
               datePicker.preferredDatePickerStyle = .wheels
           }
           datePicker.datePickerMode = .dateAndTime
           datePicker.locale = Locale(identifier: "ko-KR")
           datePicker.timeZone = .autoupdatingCurrent
       }
    
    @IBAction func DatePickerChanged(_ sender: UIDatePicker) {
        
    }
    
    func cornerChange() {
        for i in imageViewCollection {
            i.layer.cornerRadius = 12
        }
    }
    

}
