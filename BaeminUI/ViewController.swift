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
        
        view.backgroundColor = example().0
        emotionFirstButton.setImage(UIImage(named: example().2), for: .normal)
        
        emotionFirstButton.tag = 0
        
//        let image = UIImage(named: "sesac_slime6")?.withRenderingMode(.alwaysOriginal)
//        emotionFirstButton.setImage(image, for: .normal)
        
//        let systemImage = UIImage(systemName: <#T##String#>) // 애플 시스템 심볼
        
    }
    
    //배경색, 레이블, 이미지 - 타입의 제약 없이 쓸 수 있는건 튜플로 ( )
    func example() -> (UIColor, String, String) {
        let color: [UIColor] = [.yellow, .red, .blue]
        let image: [String] = ["sesac_slime6", "sesac_slime7", "sesac_slime8", "sesac_slime5"]
        return (color.randomElement()!, "고래밥", image.randomElement()!)
    }
    
    func setUserNickname() -> String {
        let nickname = ["고래밥", "칙촉", "격투가"]
        let select = nickname.randomElement()!
        
        return "저는 \(select)입니다."
    }
    
    @IBAction func emotionBtnClicked(_ sender: UIButton) {
        print(sender.tag, sender.currentTitle, sender.currentImage)
        emotionArray[sender.tag] += 1
        
        firstLabel.text = "\(emotionArray[0])"
        secondLabel.text = "\(emotionArray[1])"
        thirdLabel.text = "\(emotionArray[2])"
        fourthLabel.text = "\(emotionArray[3])"
        fifthLabel.text = "\(emotionArray[4])"
        sixthLabel.text = "\(emotionArray[5])"
        seventhLabel.text = "\(emotionArray[6])"
        eighthLabel.text = "\(emotionArray[7])"
        ninethLabel.text = "\(emotionArray[8])"
        
        showAlertController()
    
    }
    
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

