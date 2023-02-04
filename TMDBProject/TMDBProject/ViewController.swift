//
//  ViewController.swift
//  TMDBProject
//
//  Created by SeungYeon Yoo on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var list: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        requestMovieInfo()
    }
    
    func requestMovieInfo() {
        list.removeAll()
        
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.TMDB)"
        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for movie in json["results"].arrayValue {
                    let title = movie["title"].stringValue
                    let release_date = movie["release_date"].stringValue
                    let original_language = movie["original_language"].stringValue
                    
                    let data = MovieModel(movieTitle: title, releaseDate: release_date, language: original_language)
                    
                    self.list.append(data)
                }
                
                //테이블뷰 갱신
                self.mainTableView.reloadData()
                
                print(self.list)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell

        cell.movieTitle.text = "\(list[indexPath.row].movieTitle)"
        cell.languageLabel.text = "\(list[indexPath.row].language)"
        cell.releasedDateLabel.text = "\(list[indexPath.row].releaseDate)"
        
        return cell
    }

}

