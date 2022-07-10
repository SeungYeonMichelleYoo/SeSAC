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
    
    //textfield에서 키보드 엔터시 검색
    @IBAction func searchTxtField(_ sender: Any) {
        showResult()
    }
    
    @IBAction func searchBtnClicked(_ sender: UIButton) {
       showResult()
    }
    
    //키보드 내리기 (텍스트필드 외 탭할때, 돋보기 버튼 클릭시)
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func firstBtn(_ sender: UIButton) {
        showLabel.text = "1. 유무차별의 줄임말. 있고 없음을 가지고 차별하는걸 의미함. 구독자 수가 많고 적음을 가지고 차별할때 주로 사용됨. 이를테면 상대방 유튜버가 구독자가 나보다 많아서 무시할때.. 너 나 윰차 하냐? 라고 표현할 수 있음. 2. 유모차의 귀여움 버젼"
    }
    
    @IBAction func secondBtn(_ sender: UIButton) {
        showLabel.text = "실시간 매니저. 유튜브 라이브 방송에서 원활한 소통을 위해 실시간으로 시청자들을 응대하고 기본 정보를 제공하는 실시간 매니저를 말함"
    }
    
    @IBAction func thirdBtn(_ sender: UIButton) {
        showLabel.text = "만나서 반가워 잘 부탁해"
    }
    
    @IBAction func forthBtn(_ sender: UIButton) {
        showLabel.text = "꾸민 듯 안 꾸민 듯"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTextField.layer.borderWidth = 1.0
        firstTextField.layer.borderColor = UIColor.black.cgColor
        
        bgImageView.layer.borderWidth = 1.0
        bgImageView.layer.borderColor = UIColor.black.cgColor
        
        studyOutletCollection()
    }
    
    func studyOutletCollection() {
        for item in buttonList {
            item.layer.borderWidth = 1.0
            item.layer.cornerRadius = 8
            item.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    
    //검색시 라벨에 결과 보여줌
    func showResult() {
        if firstTextField.text == "윰차" {
            showLabel.text = "1. 유무차별의 줄임말. 있고 없음을 가지고 차별하는걸 의미함. 구독자 수가 많고 적음을 가지고 차별할때 주로 사용됨. 이를테면 상대방 유튜버가 구독자가 나보다 많아서 무시할때.. 너 나 윰차 하냐? 라고 표현할 수 있음. 2. 유모차의 귀여움 버젼"
        }
        else if firstTextField.text == "실매" {
            showLabel.text = "실시간 매니저. 유튜브 라이브 방송에서 원활한 소통을 위해 실시간으로 시청자들을 응대하고 기본 정보를 제공하는 실시간 매니저를 말함"
        }
        else if firstTextField.text == "만만잘부" {
            showLabel.text = "만나서 반가워 잘 부탁해"
        }
        else if firstTextField.text == "꾸안꾸" {
            showLabel.text = "꾸민 듯 안 꾸민 듯"
        } else {
            showLabel.text = "해시태그 글자 중 입력해주세요."
        }
    }
}
