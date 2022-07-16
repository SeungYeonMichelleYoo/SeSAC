//
//  ViewController.swift
//  newlyCoinedWord
//
//  Created by SeungYeon Yoo on 2022/07/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet var buttonList: [UIButton]!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    enum Enum: String, CaseIterable {
        case 윰차
        case 실매
        case 만만잘부
        case 꾸안꾸
        case 당모치
        case 쪄죽따
        // case 다른 단어를 입력한 경우?? -> switch에서 default로 처리.
    }
    
    //딕셔너리 선언 - [단어 : 뜻] 매칭
    let newWords: [String: String] = ["윰차": "1. 유무차별의 줄임말. 있고 없음을 가지고 차별하는걸 의미함. 구독자 수가 많고 적음을 가지고 차별할때 주로 사용됨. 이를테면 상대방 유튜버가 구독자가 나보다 많아서 무시할때.. 너 나 윰차 하냐? 라고 표현할 수 있음. 2. 유모차의 귀여움 버젼", "실매": "실시간 매니저. 유튜브 라이브 방송에서 원활한 소통을 위해 실시간으로 시청자들을 응대하고 기본 정보를 제공하는 실시간 매니저를 말함", "만만잘부": "만나서 반가워 잘 부탁해", "꾸안꾸": "꾸민 듯 안 꾸민듯", "당모치": "당연히 모든 치킨은 옳다", "쪄죽따": "쪄 죽어도 따뜻한 아메리카노"]
    
    //버튼 4개에 랜덤으로 신조어단어를 뿌려준다 (Enum 값 중에 가져와서 setTitle로 뿌려준다)
    func randomWords() {
        //중복 방지를 위해 newWords를 가져오기 위한 선언
        var container: [String] = [] // 비어있는 배열. while을 돌면서 [윰차, 실매, 꾸안꾸... ] 식으로 쌓임.
        while container.count < 4 {
            let newWord = Enum.allCases.randomElement()! //enum을 가져오는거. 6개 중 하나의 값. 윰차
            let data = newWord.rawValue //enum을 String형태로 가져온다. "윰차"
            
            if !container.contains(data) {
                buttonList[container.count].setTitle(data, for: .normal)
                container.append(data)
            }
        }
    }
    
    //텍스트필드에 무언가 입력되었을 때 또는 버튼중 하나를 클릭했을 때 단어-뜻 매칭하여 검색 효과 (txtVal : 매개변수)
    func changeTextField(txtVal: String) {
        switch txtVal {
                case "윰차":
                    showLabel.text = "1. 유무차별의 줄임말. 있고 없음을 가지고 차별하는걸 의미함. 구독자 수가 많고 적음을 가지고 차별할때 주로 사용됨. 이를테면 상대방 유튜버가 구독자가 나보다 많아서 무시할때.. 너 나 윰차 하냐? 라고 표현할 수 있음. 2. 유모차의 귀여움 버젼"
                case "실매":
                    showLabel.text = "실시간 매니저. 유튜브 라이브 방송에서 원활한 소통을 위해 실시간으로 시청자들을 응대하고 기본 정보를 제공하는 실시간 매니저를 말함"
                case "만만잘부":
                    showLabel.text = "만나서 반가워 잘 부탁해"
                case "꾸안꾸":
                    showLabel.text = "꾸민 듯 안 꾸민 듯"
                case "당모치":
                    showLabel.text = "당연히 모든 치킨은 옳다"
                case "쪄죽따":
                    showLabel.text = "쪄 죽어도 따뜻한 아메리카노"
                default :
                    showLabel.text = "추천 단어 중 입력해주세요."
                }
    }
    
    //textfield에서 키보드 엔터시 검색
    @IBAction func searchTxtField(_ sender: Any) {
        changeTextField(txtVal: firstTextField.text!)
    }
    
    //textfield에서 돋보기 눌렀을 때 검색
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        changeTextField(txtVal: firstTextField.text!)
        // firstTextField.text
    }
    
    //키보드 내리기 (텍스트필드 외 탭할때, 돋보기 버튼 클릭시)
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    //enum 리스트에 있는 단어들을 버튼에 랜덤으로 보여주어야 함
//    let p = CompassPoint.north
//    dump(p.rawValue) // "north"
//    dump(p.south.rawValue) // "South"
//
//    let showRandomonBtn = Words.윰차
//    print(showRandomonBtn.rawValue)
//    allCases.randomElement()
//    print(showRandomonBtn)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTextField.layer.borderWidth = 1.0
        firstTextField.layer.borderColor = UIColor.black.cgColor
        
        bgImageView.layer.borderWidth = 1.0
        bgImageView.layer.borderColor = UIColor.black.cgColor
        
        studyOutletCollection()
        randomWords()

    }
    
    func studyOutletCollection() {
        for item in buttonList {
            item.layer.borderWidth = 1.0
            item.layer.cornerRadius = 8
            item.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        changeTextField(txtVal: sender.currentTitle!)
    }
    
    
}
