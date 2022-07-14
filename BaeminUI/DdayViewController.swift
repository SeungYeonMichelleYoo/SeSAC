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

    @IBOutlet weak var d100Label: UILabel!
    @IBOutlet weak var d200Label: UILabel!
    @IBOutlet weak var d300Label: UILabel!
    @IBOutlet weak var d400Label: UILabel!
    
//    var dDayLabelArray =
    
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
           datePicker.datePickerMode = .date
           datePicker.locale = Locale(identifier: "ko-KR")
           datePicker.timeZone = .autoupdatingCurrent
   }
    
    @IBAction func DatePickerChanged(_ sender: UIDatePicker) {
        changed()
    }
    
    func changed() {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
        dateformatter.timeStyle = .none
        let date = datePicker.date
        let pickerDatePlus100Days = Calendar.current.date(byAdding: .day, value: 100, to: date)
        let pickerDatePlus200Days = Calendar.current.date(byAdding: .day, value: 200, to: date)
        let pickerDatePlus300Days = Calendar.current.date(byAdding: .day, value: 300, to: date)
        let pickerDatePlus400Days = Calendar.current.date(byAdding: .day, value: 400, to: date)
        print(pickerDatePlus100Days)
        print(date)
        d100Label.text = pickerDatePlus100Days?.formatted()
        d200Label.text = pickerDatePlus200Days?.formatted()
        d300Label.text = pickerDatePlus300Days?.formatted()
        d400Label.text = pickerDatePlus400Days?.formatted()
        //dateformatter 에 대한 공부가 더 필요함.
    }
    
    func cornerChange() {
        for i in imageViewCollection {
            i.layer.cornerRadius = 12
        }
    }
    

}
