//
//  ViewController.swift
//  Movie
//
//  Created by SeungYeon Yoo on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var MovieBtn: UIButton!
    @IBOutlet weak var MovieBtn2: UIButton!
    @IBOutlet weak var MovieBtn3: UIButton!
    
    @IBOutlet weak var backgroundUIImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieBtn.layer.cornerRadius = MovieBtn.frame.height/2
        MovieBtn.layer.borderWidth = 5
        MovieBtn.layer.borderColor = UIColor.blue.cgColor
        
        MovieBtn2.layer.cornerRadius = 100
        MovieBtn2.layer.borderWidth = 3
        MovieBtn2.layer.borderColor = UIColor.red.cgColor
        
        MovieBtn3.layer.cornerRadius = 120
        MovieBtn3.layer.borderWidth = 2
        MovieBtn3.layer.borderColor = UIColor.yellow.cgColor
    }
    
    @IBAction func playBtnClicked(_ sender: UIButton) {
        backgroundUIImage.image = UIImage(named: "movie\(Int.random(in:1...4))")
    }
}

