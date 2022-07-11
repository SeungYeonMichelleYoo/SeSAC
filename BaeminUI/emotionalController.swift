//
//  emotionalController.swift
//  BaeminUI
//
//  Created by SeungYeon Yoo on 2022/07/11.
//

import UIKit

class emotionalController: UIViewController {
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBAction func Btn1(_ sender: UIButton) {
        firstLabel.text = "0"
//        firstLabel.text = Int(0)
//        firstLabel.text += 1
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
