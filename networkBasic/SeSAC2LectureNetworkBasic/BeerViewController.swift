//
//  BeerViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by SeungYeon Yoo on 2022/08/01.
//

import UIKit

import Alamofire
import SwiftyJSON

class BeerViewController: UIViewController {
    
    @IBOutlet weak var beerNameUILabel: UILabel!
    @IBOutlet weak var beerUIImage: UIImageView!
    @IBOutlet weak var descriptionUILabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
       requestBeer(number: Int.random(in: 1...325))
    }
    
    func requestBeer(number: Int) {
        let url = "https://api.punkapi.com/v2/beers/\(number)"
        AF.request(url, method: .get).validate().responseJSON { response  in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                print("JSONArray: \(json.array![0]["name"].stringValue)")
                
                self.beerNameUILabel.text = json.array![0]["name"].stringValue
                let imageUrl = URL(string: json.array![0]["image_url"].stringValue)
                if imageUrl != nil {
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: imageUrl!)
                        DispatchQueue.main.async {
                            self.beerUIImage.image = UIImage(data: data!)
                            self.beerUIImage.isHidden = false
                        }
                    }
                } else {
                    self.beerUIImage.isHidden = true
                }
         
                self.descriptionUILabel.text = json.array![0]["description"].stringValue
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
