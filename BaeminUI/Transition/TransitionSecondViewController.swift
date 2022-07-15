//
//  TransitionSecondViewController.swift
//  BaeminUI
//
//  Created by SeungYeon Yoo on 2022/07/15.
//

import UIKit

class TransitionSecondViewController: UIViewController {
    
    
    //감정 갯수 영구적으로 저장하기
    @IBOutlet weak var countLabel: UILabel!
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        
        //기존 데이터 값 가져오기
        let currentValue = UserDefaults.standard.integer(forKey: "happyEmotion") //key이름은 맘대로 해도 됨
        
        //감정 + 1
        let updateValue = currentValue + 1
        
        //새로운 값 저장
        UserDefaults.standard.set(updateValue, forKey: "happyEmotion")
        
        //레이블에 새로운 내용 보여주기
        countLabel.text = "\(UserDefaults.standard.integer(forKey: "happyEmotion"))"
        
        
//        var emotionCount = 0
//
//        countLabel.text = emotionCount + 1
//
//        UserDefaults.standard.set(countLabel.text, forKey: "nickname")
//
//        if UserDefaults.standard.string(forKey: "nickname") != nil {
//
//        //가져오기(어떤 타입으로 가져올지 정할 수 있음)
//        countLabel.text = UserDefaults.standard.string(forKey: "nickname")
//        } else {
//            //데이터가 없는 경우에 사용할 문구
//            countLabel.text = "0" 내가 짜본 코드 위에는.
    }
    
    
    
    @IBOutlet weak var mottoTextView: UITextView!
    /*
     1. 앱 켜면 데이터를 가지고 와서 텍스트뷰에 보여주어야함.
     2. 바뀐 데이터를 저장해주어야 한다. (고래밥->칙촉)
     => UserDefault (key-value형태로 저장되어있음)
     
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLabel.text = "\(UserDefaults.standard.integer(forKey: "happyEmotion"))"
        
        print("TransitionSecondViewController", #function)
        
        if UserDefaults.standard.string(forKey: "nickname") != nil {
        
        //가져오기(어떤 타입으로 가져올지 정할 수 있음)
        mottoTextView.text = UserDefaults.standard.string(forKey: "nickname")
        } else {
            //데이터가 없는 경우에 사용할 문구
            mottoTextView.text = "고래밥"
        }
        
        print(UserDefaults.standard.string(forKey: "phoneNumber"))
        print(UserDefaults.standard.integer(forKey: "age"))
        print(UserDefaults.standard.bool(forKey: "inapp"))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("TransitionSecondViewController",#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("TransitionSecondViewController",#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("TransitionSecondViewController",#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("TransitionSecondViewController",#function)
    }

    @IBAction func saveButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(mottoTextView.text, forKey: "nickname")
        print("저장되었습니다.")
    }
}
