//
//  SearchAPIManager.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/05.
//

import Foundation
import Alamofire
import SwiftyJSON


//클래스 싱글턴 패턴
class SearchAPIManager {

    static let shared = SearchAPIManager()

    private init() { }

    typealias completionHandler = (Int, [MovieModel]) -> Void
    typealias peopleHandler = (Int, [String]) -> Void
    
    //non-escaping -> escaping
    func fetchData(query: String, startPage: Int, completionHandler: @escaping completionHandler) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "\(EndPoint.movieSearchUrl)\(APIKey.keyAPI)"
        print(url)
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                let totalCount = json["results"].arrayValue.count
                
                var list: [MovieModel] = []
                
                let GENRE = ["28":"Action", "12":"Adventure", "16":"Animation", "35":"Comedy", "80":"Crime", "99":"Documentary", "18":"Drama", "10751":"Family", "14":"Fantasy", "36":"History", "27":"Horror", "10402":"Music", "9648":"Mystery", "10749":"Romance", "878":"Science Fiction", "10770":"TV Movie", "53":"Thriller", "10752":"War", "37":"Western"]
                var counter = 0
                for movie in json["results"].arrayValue {
                    
                    let movieTitle = movie["title"].stringValue
                    let rate = movie["vote_average"].doubleValue
                    let releasedDate = movie["release_date"].stringValue
                    let posterImage = "\(EndPoint.imageURL)\(movie["poster_path"].stringValue)"
                    let overview = movie["overview"].stringValue
                    var genreList: [String] = []
                    var castList: [String] = []
                    for genreKey in movie["genre_ids"].arrayValue {
                        genreList.append("#"+GENRE[String(genreKey.intValue)]!)
                    }
                    let id = movie["id"].stringValue
                    self.peopleFetch(id: id) { totalCount2, list2 in
                        
                        castList.append(contentsOf: list2)
                        
                        DispatchQueue.main.async {
                            counter = counter + 1
                            let data = MovieModel(movieTitle: movieTitle, genre: genreList.joined(separator: " "), rate: rate, posterImage: posterImage, releasedDate: releasedDate, overview: overview, casted: castList)
                            list.append(data)
                            
                            if counter == totalCount {
                                completionHandler(list.count, list)
                            }

                        }

                    }
                }
                
                case .failure(let error):
                print(error)
            }
                       
            
        }
    }
    
    //non-escaping -> escaping
    func peopleFetch(id: String, peopleHandler: @escaping peopleHandler) {
        let peopleUrl = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=aa647781e526d18186b74e24132beb08"

        AF.request(peopleUrl, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
        
                var peopleList: [String] = []
        
                let people = json["cast"].arrayValue //[0]["name"].stringValue
                for person in people {
                    peopleList.append(person["name"].stringValue)
                }
                //print("People: " + people)
                let peopletotalCount = peopleList.count
                
                peopleHandler(peopleList.count, peopleList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
