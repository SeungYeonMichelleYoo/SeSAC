//
//  FirstViewController.swift
//  Diary_Week7
//
//  Created by SeungYeon Yoo on 2022/08/16.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var blackView: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starImageView.image = UIImage(systemName: "star.fill")

        tutorialLabel.numberOfLines = 0
//        tutorialLabel.alpha = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 25)
        tutorialLabel.backgroundColor = .red
        tutorialLabel.text = """
        일기 씁시다!
        잘 써봅시다!
        """
        tutorialLabel.alpha = 0
        
        blackView.backgroundColor = .black
        blackView.alpha = 0
        
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
//            self.tutorialLabel.backgroundColor = .yellow
        } completion: { _ in
            self.animateBlackView()
        }
        
    }
    func animateBlackView() {
        UIView.animate(withDuration: 2) {
            self.blackView.transform = CGAffineTransform(scaleX: 3, y: 1)
            self.blackView.alpha = 1
        } completion: { _ in
            self.animationImageView()
        }
    }
    
    func animationImageView() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            self.starImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }

    }
    
}
