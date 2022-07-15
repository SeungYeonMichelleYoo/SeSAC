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
        labelTextChange()
    }
    
    private func labelTextChange() {
        d100Label.textColor = .white
        d200Label.textColor = .white
        d300Label.textColor = .white
        d400Label.textColor = .white
        
        d100Label.font = UIFont.boldSystemFont(ofSize: 20.0)
        d200Label.font = UIFont.boldSystemFont(ofSize: 20.0)
        d300Label.font = UIFont.boldSystemFont(ofSize: 20.0)
        d400Label.font = UIFont.boldSystemFont(ofSize: 20.0)
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
           datePicker.timeZone = .autoupdatingCurrent
   }
    
    
    @IBAction func DatePickerChanged(_ sender: UIDatePicker) {
        changed()
    }
    
    func changed() {
        //달력에서 본인이 선택한 날짜를 변수에 담음
        let date = datePicker.date
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
        dateformatter.timeStyle = .none
        //한국시간으로 표시
        dateformatter.locale = Locale(identifier: "ko_kr")
        //형태변환
        dateformatter.dateFormat = "yyyy년 MM월 dd일"
        
        //선택한 날짜에 D+100, D+200,... 더하기
        let pickerDatePlus100Days = Calendar.current.date(byAdding: .day, value: 100, to: date)
        let pickerDatePlus200Days = Calendar.current.date(byAdding: .day, value: 200, to: date)
        let pickerDatePlus300Days = Calendar.current.date(byAdding: .day, value: 300, to: date)
        let pickerDatePlus400Days = Calendar.current.date(byAdding: .day, value: 400, to: date)
        
        //라벨에 출력하기 위해서 string으로 변환 및 dateformatter 적용
        let str_100d = dateformatter.string(from: pickerDatePlus100Days!)
        let str_200d = dateformatter.string(from: pickerDatePlus200Days!)
        let str_300d = dateformatter.string(from: pickerDatePlus300Days!)
        let str_400d = dateformatter.string(from: pickerDatePlus400Days!)
        
        //라벨에 내용 출력
        d100Label.text = str_100d
        d200Label.text = str_200d
        d300Label.text = str_300d
        d400Label.text = str_400d
    }
    
    func cornerChange() {
        for i in imageViewCollection {
            i.layer.cornerRadius = 12
        }
    }
    

}
