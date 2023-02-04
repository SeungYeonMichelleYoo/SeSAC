//
//  TextFieldController.swift
//  BaeminUI
//
//  Created by SeungYeon Yoo on 2022/07/14.
//

import UIKit

class TextFieldController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       //DateFormatter: 알아보기 쉬운 날짜 + 시간대 (yyyy MM dd hh:mm:ss) //월은 대문자 M써야함
        let format = DateFormatter()
        format.dateFormat = "M월 d일, yy년"
//        format.locale
        
        let result = format.string(from: Date() ) //Date()는 현재시간이 나타난다.(영국표준시)
        print(result, Date() )
        
        let word = "3월 2일, 19년"
        let dateResult = format.date(from: word)
        print(dateResult)
    }
    



}
