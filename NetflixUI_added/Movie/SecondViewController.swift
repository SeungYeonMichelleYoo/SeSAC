//
//  SecondViewController.swift
//  Movie
//
//  Created by SeungYeon Yoo on 2022/07/05.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bannerImgImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    //뷰컨트롤러의 생명주기 종류 중 하나
    //사용자에게 화면이 보이기 직전에 (모서리 둥글게, 그림자, 등등) 실행되는 코드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerImgImageView.image = UIImage(named: "movie\(Int.random(in:1...5))")
        bannerImgImageView.layer.cornerRadius = 100
        bannerImgImageView.layer.borderWidth = 5
        bannerImgImageView.layer.borderColor = UIColor.blue.cgColor
        
        movieTitleLabel.text = "택시운전사"
        movieTitleLabel.backgroundColor = .yellow
        movieTitleLabel.textColor = .red
        movieTitleLabel.font = .boldSystemFont(ofSize: 30)
    }
    
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        bannerImgImageView.image = UIImage(named: "movie\(Int.random(in:1...5))")
    }
}
