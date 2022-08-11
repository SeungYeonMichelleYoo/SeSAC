//
//  GenreAPIManager.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class GenreAPIManager {
    
    //인스턴스 생성
    static let shared = GenreAPIManager()
    
    //초기화되지 않도록 방지
    private init() { }
    
    let genreList = ["28":"Action", "12":"Adventure", "16":"Animation", "35":"Comedy", "80":"Crime", "99":"Documentary", "18":"Drama", "10751":"Family", "14":"Fantasy", "36":"History", "27":"Horror", "10402":"Music", "9648":"Mystery", "10749":"Romance", "878":"Science Fiction", "10770":"TV Movie", "53":"Thriller", "10752":"War", "37":"Western"]
    
    var movieIdList: [Int] = []
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    
    //query: 위의 영화 아이디 숫자값을 받아옴
    func callRequest(query: String, completionHandler: @escaping ([String]) -> () ) {
        print(#function)
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=\(APIKey.keyAPI)&with_genres=\(query)"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var posterArray: [String] = []
                
                // json["results"].arrayValue : list of movie data
                for movie in json["results"].arrayValue {
                    if !self.movieIdList.contains(movie["id"].intValue) {
                        self.movieIdList.append(movie["id"].intValue)
                        let image = movie["poster_path"].stringValue
                        posterArray.append(image)
                    }
                }
                                
                completionHandler(posterArray)
                                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestImage(completionHandler: @escaping ([[String]]) -> ()) {
        var posterList: [[String]] = []
        let keyList = [String] (self.genreList.keys)
        GenreAPIManager.shared.callRequest(query: keyList[0]) { value in
            posterList.append(value)
            
            GenreAPIManager.shared.callRequest(query: keyList[1]) { value in
                posterList.append(value)
                
                GenreAPIManager.shared.callRequest(query: keyList[2]) { value in
                    posterList.append(value)
                    
                    GenreAPIManager.shared.callRequest(query: keyList[3]) { value in
                        posterList.append(value)
                        
                        GenreAPIManager.shared.callRequest(query: keyList[4]) { value in
                            posterList.append(value)
                            
                            GenreAPIManager.shared.callRequest(query: keyList[5]) { value in
                                posterList.append(value)
                                
                                GenreAPIManager.shared.callRequest(query: keyList[6]) { value in
                                    posterList.append(value)
                                    
                                    GenreAPIManager.shared.callRequest(query: keyList[7]) { value in
                                        posterList.append(value)
                                        
                                        GenreAPIManager.shared.callRequest(query: keyList[8]) { value in
                                            posterList.append(value)
                                            
                                            GenreAPIManager.shared.callRequest(query: keyList[9]) { value in
                                                posterList.append(value)
                                                
                                                GenreAPIManager.shared.callRequest(query: keyList[10]) { value in
                                                    posterList.append(value)
                                                    
                                                    GenreAPIManager.shared.callRequest(query: keyList[11]) { value in
                                                        posterList.append(value)
                                                        
                                                        GenreAPIManager.shared.callRequest(query: keyList[12]) { value in
                                                            posterList.append(value)
                                                            
                                                            GenreAPIManager.shared.callRequest(query: keyList[13]) { value in
                                                                posterList.append(value)
                                                                
                                                                GenreAPIManager.shared.callRequest(query: keyList[14]) { value in
                                                                    posterList.append(value)
                                                                    
                                                                    GenreAPIManager.shared.callRequest(query: keyList[15]) { value in
                                                                        posterList.append(value)
                                                                        
                                                                        GenreAPIManager.shared.callRequest(query: keyList[16]) { value in
                                                                            posterList.append(value)
                                                                            
                                                                            GenreAPIManager.shared.callRequest(query: keyList[17]) { value in
                                                                                posterList.append(value)
                                                                                
                                                                                GenreAPIManager.shared.callRequest(query: keyList[18]) { value in
                                                                                    posterList.append(value)
                                                                                    completionHandler(posterList)
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
