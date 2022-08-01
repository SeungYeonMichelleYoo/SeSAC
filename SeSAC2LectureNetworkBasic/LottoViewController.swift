//
//  LottoViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by SeungYeon Yoo on 2022/07/28.
//

import UIKit

//1. 임포트
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    
    @IBOutlet weak var firstUILabel: UILabel!
    @IBOutlet weak var secondUILabel: UILabel!
    @IBOutlet weak var thirdUILabel: UILabel!
    @IBOutlet weak var fourthUILabel: UILabel!
    @IBOutlet weak var fifthUILabel: UILabel!
    @IBOutlet weak var sixthUILabel: UILabel!
    @IBOutlet weak var seventhUILabel: UILabel!
    
    @IBOutlet weak var numberTextField: UITextField!
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    //인스턴스 생성. 스토리보드에 있지는 않지만 아래 피커뷰 코드와 연결이 된다
    //코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있다.
    var lottoPickerView = UIPickerView()
    
    let numberList: [Int] = Array(1...1025).reversed() //거꾸로 돌리기(.reversed())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //텍스트필드를 클릭했을 때 pickerview 보여주게 한다. PickerView가 하나가 더 떠서 올라옴 (여기 다양한 종류의 pickerview올릴 수 있음)
        
        numberTextField.textContentType = .oneTimeCode //인증번호
        
        numberTextField.tintColor = .clear // 커서 투명하게
        numberTextField.inputView = lottoPickerView
        //텍스트필드에 커서를 찍으면 원래 키보드가 올라오는데, 스토리보드의 피커뷰를 지우고 코드로 구현해줌. 키보드 대신에 피커뷰가 뜨게끔 하는 코드
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        requestLotto(number: 986)
    
    }
    
    func requestLotto(number: Int) {
        
        //AF: 200~299 status code 301 //validate: 유효성검증 - 네트워크 성공이 되는 범위 써주는 곳
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let bonus = json["bnusNo"].intValue
                print(bonus)
                
                let date = json["drwNoDate"].stringValue
                print(date)
                
                //텍스트필드에 날짜 보여주기
                self.numberTextField.text = date
            
                let labels = [firstUILabel, secondUILabel, thirdUILabel, fourthUILabel, fifthUILabel, sixthUILabel]
                
                //1~6번째 숫자 보여주기
                for i in 1...6 {
                    labels[i-1]?.text = String(json["drwtNo\(i)"].intValue)
                }
                
                //보너스 7번째 숫자 보여주기
                self.seventhUILabel.text = String(bonus)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

//아래처럼 쓰는게 편함 (따로 파일 만들지 않고. 해당 익스텐션 접어두는 편.) (한번 만들고 거의 고칠 일 없어서)
extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
        numberTextField.text = "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
