//
//  ViewController.swift
//  BaeminUI
//
//  Created by SeungYeon Yoo on 2022/07/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var sixthLabel: UILabel!
    @IBOutlet weak var seventhLabel: UILabel!
    @IBOutlet weak var eighthLabel: UILabel!
    @IBOutlet weak var ninethLabel: UILabel!
    
    @IBOutlet weak var emotionFirstButton: UIButton!
    
    var emotionArray = [0,0,0,0,0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLabel.text = setUserNickname()
        
        view.backgroundColor = example().0 //아래 적은 튜플의 첫번째 요소인 UIColor
 
        emotionFirstButton.setImage(UIImage(named: example().2), for: .normal) //첫번째 버튼의 이미지
        
        emotionFirstButton.tag = 0 //버튼 태그 초기값 ??
        
//        let image = UIImage(named: "sesac_slime6")?.withRenderingMode(.alwaysOriginal)
//        emotionFirstButton.setImage(image, for: .normal)
        
//        let systemImage = UIImage(systemName: <#T##String#>) // 애플 시스템 심볼
        
    }
    
    //배경색, 레이블, 이미지 - 타입의 제약 없이 쓸 수 있는건 튜플로 ( )
    func example() -> (UIColor, String, String) {
        let color: [UIColor] = [.yellow, .red, .systemPink]
        let image: [String] = ["sesac_slime6", "sesac_slime7", "sesac_slime8", "sesac_slime5"]
        return (color.randomElement()!, "고래밥", image.randomElement()!)
    }
    
    func setUserNickname() -> String {
        let nickname = ["고래밥", "칙촉", "격투가"]
        let select = nickname.randomElement()!
        return "저는 \(select)입니다."
    }
    
    @IBAction func emotionBtnClicked(_ sender: UIButton) {
        print(sender.tag, sender.currentTitle, sender.currentImage) //옵셔널로 찍혀서 print 확인 불가
        emotionArray[sender.tag] += 1
        print(sender.tag) //몇 번째 버튼을 클릭하는지 tag 숫자가 찍힌다.
        
        firstLabel.text = "행복해 \(emotionArray[0])"
        secondLabel.text = "사랑해 \(emotionArray[1])"
        thirdLabel.text = "좋아해 \(emotionArray[2])"
        fourthLabel.text = "당황해 \(emotionArray[3])"
        fifthLabel.text = "속상해 \(emotionArray[4])"
        sixthLabel.text = "우울해 \(emotionArray[5])"
        seventhLabel.text = "심심해 \(emotionArray[6])"
        eighthLabel.text = "행복해 \(emotionArray[7])"
        ninethLabel.text = "속상해 \(emotionArray[8])"
        
        showAlertController()
    
    }
// MARK : - Alert
    func showAlertController() {
        
        //1. 흰 바탕: UIAlertController
        let alert = UIAlertController(title: "타이틀", message: "여기는 메시지가 들어갑니다", preferredStyle: .alert)
        
        //2. 버튼
        let ok = UIAlertAction(title: "확인", style: .destructive, handler: nil)
        let cancel = UIAlertAction(title: "취소버튼입니다.", style: .cancel, handler: nil)
        let web = UIAlertAction(title: "새 창으로 열기", style: .default, handler: nil)
        let copy = UIAlertAction(title: "복사하기", style: .default, handler: nil)
        
        
        //3. 1+2
        alert.addAction(ok)
        alert.addAction(cancel)
        alert.addAction(web)
        alert.addAction(copy)
        
        //4. present
        present(alert, animated: true, completion: nil)
        
    }
}

