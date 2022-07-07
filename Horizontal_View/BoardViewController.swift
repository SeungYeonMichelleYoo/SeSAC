//
//  BoardViewController.swift
//  Horizontal_View
//
//  Created by SeungYeon Yoo on 2022/07/06.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var textColorButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet var buttonList: [UIButton]! // 아웃렛 컬렉션
    
    @IBAction func endEditing(_ sender: UITextField) {
            view.endEditing(true)
    }
    
    @IBOutlet weak var upperView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designButton(sendButton, buttonTitle: "전송", HighlightedTitle: " 빨리보내", buttonBackground: .red)
        designButton(textColorButton, buttonTitle: "Button", HighlightedTitle: "색상변경", buttonBackground: .blue)
        designTextField()
        
    }
    
    func designTextField() {
        userTextField.placeholder = "내용을 작성해주세요"
        userTextField.text = "안녕하세요"
        userTextField.keyboardType = .emailAddress
        userTextField.font = .systemFont(ofSize: 15)
        userTextField.borderStyle = .none
        userTextField.textColor = .blue
    }
    
    //buttonOutletVariableName: 외부 매개변수, Argument Label -> 생략 가능 (앞쪽에 _ 언더바 쓰면 생략 가능)
    //buttonName: 내부 매개변수, Parameter Name
    // _ : 와일드 카드 식별자
    func designButton(_ buttonName: UIButton, buttonTitle: String, HighlightedTitle: String, buttonBackground bgColor: UIColor) { // () : 함수 호출 연산자
        buttonName.setTitle(buttonTitle, for: .normal)
        buttonName.setTitle(HighlightedTitle, for: .highlighted)
        buttonName.backgroundColor = bgColor
        buttonName.layer.cornerRadius = 8
        buttonName.layer.borderColor = UIColor.black.cgColor
        buttonName.layer.borderWidth = 3
        buttonName.setTitleColor(.red, for: .normal)
        buttonName.setTitleColor(.blue, for: .highlighted)
    }
    
    func studyOutletCollection() {
        
        //1. 반복문
        let buttonArray : [UIButton] = [sendButton, textColorButton]
        
        for item in buttonArray {
            item.backgroundColor = .blue
            item.layer.cornerRadius = 2
        }
        
        //위 반복문 쓰는 대신 스토리보드에서 Outlet Collection 으로 연결 가능
        //(버튼 여러개에 연결 가능)
        
        //2. 아웃렛 컬렉션
        for item in buttonList {
            item.backgroundColor = .blue
            item.layer.cornerRadius = 2
        }
    }
  
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        
        print(sendButton.currentTitle)
        
        resultLabel.text = userTextField.text
        
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        //키보드 내리기
        view.endEditing(true)
        
        if upperView.isHidden {
            upperView.isHidden = false
        } else {
            upperView.isHidden = true
        }
        
    }

    @IBAction func exampleBtn1(_ sender: UIButton) {
        view.endEditing(true)
    }
    //함수는 하나인데 여러군데 연결 가능. 어떤 버튼 클릭하더라도 이 함수 실행된다.
  
    //연결관계를 다 끊어보고, Any로 연결해보기
    
//    @IBAction func keyboardDismiss(_ sender: Any) {
//        view.endEditing(true)
//    }
    
    
    
}
