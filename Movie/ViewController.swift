//
//  ViewController.swift
//  Movie
//
//  Created by SeungYeon Yoo on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var MovieBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieBtn.layer.cornerRadius = 20
    }
}

