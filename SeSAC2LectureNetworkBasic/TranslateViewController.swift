//
//  TranslateViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by SeungYeon Yoo on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

//UIButton, UITextField -> action연결 가능
//UITextView, UISearchBar, UIPickerView -> 액션 연결 불가
//왜? view를 상속 받았기 때문(아래 3가지) / but 버튼, 텍스트필드는 view->control을 상속 받았기 때문에
//UIControl

//UIResponderChain 1)apple문서 2)블로그 => resignFirstResponder() / becomeFirstResponder()

class TranslateViewController: UIViewController {
    @IBOutlet weak var userInputTextView: UITextView!
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        userInputTextView.font = UIFont(name: "S-CoreDream-1Thin", size: 17)
        
        requestTranslatedData()
    }
    
    func requestTranslatedData() {
        
        let url = EndPoint.translateURL
        
        let parameter = ["source": "ko", "target": "en", "text": "안녕하세요 저는 고래밥 과자를 좋아합니다."]
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .post, parameters: parameter, headers: header).validate(statusCode: 200..<500).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    self.userInputTextView.text = json["message"]["result"]["translatedText"].stringValue
                } else {
                    self.userInputTextView.text = json["errorMessage"].stringValue
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
extension TranslateViewController: UITextViewDelegate {
    
    //텍스트뷰의 텍스트가 변할 때마다 호출 (자소서에서 500자 감지 이런거)
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    //편집이 시작될 때. 커서가 시작될 때
    //텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝났을 때. 커서가 없어지는 순간
    //텍스트뷰 글자: 사용자가 아무 글자도 안썼으면 플레이스 홀더 글자 보이게 해!
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
