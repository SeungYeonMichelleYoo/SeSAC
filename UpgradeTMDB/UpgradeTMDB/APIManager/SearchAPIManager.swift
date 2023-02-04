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
    typealias peopleHandler = (Int, Int, [PeopleModel], [PeopleModel]) -> Void
    typealias youtubeHandler = (String) -> Void
    
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
                    let posterImage = "\(EndPoint.posterimageURL)\(movie["poster_path"].stringValue)"
                    let overview = movie["overview"].stringValue
                    var genreList: [String] = []
                    var castsList: [PeopleModel] = []
                    var crewsList: [PeopleModel] = []
                    for genreKey in movie["genre_ids"].arrayValue {
                        genreList.append("#"+GENRE[String(genreKey.intValue)]!)
                    }
                    let id = movie["id"].stringValue
                        
                        DispatchQueue.main.async {
                            self.peopleFetch(id: id) { castCount, crewCount, casts, crews in
                                
                                castsList.append(contentsOf: casts)
                                crewsList.append(contentsOf: crews)
                                
                            self.youtubeFetch(id: id) { youtubeKey in
                                counter = counter + 1
                                
                                let data = MovieModel(movieTitle: movieTitle, genre: genreList.joined(separator: " "), rate: rate, posterImage: posterImage, releasedDate: releasedDate, overview: overview, castedList: castsList, crewList: crewsList, youtubeKey: youtubeKey)
                                list.append(data)
                                
                                if counter == totalCount {
                                    completionHandler(list.count, list)
                                }
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
                
                var castsList: [PeopleModel] = []
                var crewsList: [PeopleModel] = []
        
                //MARK: - cast
                for cast in json["cast"].arrayValue {
                    castsList.append(PeopleModel(personName: cast["name"].stringValue, personImage: "https://image.tmdb.org/t/p/w500/\(cast["profile_path"].stringValue)", character: cast["character"].stringValue))
                }
                
                //MARK: - crew
                for crew in json["crew"].arrayValue {
                    crewsList.append(PeopleModel(personName: crew["name"].stringValue, personImage: "https://image.tmdb.org/t/p/w500/\(crew["profile_path"].stringValue)", character: crew["character"].stringValue))
                }
                                
                peopleHandler(castsList.count, crewsList.count, castsList, crewsList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func youtubeFetch(id: String, youtubeHandler: @escaping youtubeHandler) {
        let youtubeUrl = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=aa647781e526d18186b74e24132beb08"

        AF.request(youtubeUrl, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let youtube = json["results"].arrayValue[0]["key"].stringValue
               
                youtubeHandler(youtube)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
