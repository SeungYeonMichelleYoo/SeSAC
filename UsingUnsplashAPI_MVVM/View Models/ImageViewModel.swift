//
//  ImageViewModel.swift
//  UsingUnsplashAPI_MVVM
//
//  Created by SeungYeon Yoo on 2022/11/05.
//
import Foundation

enum SearchError: Error {
    case noPhoto
    case serverError
}

class ImageViewModel {
    
    typealias completionHandler = ([SearchResult]) -> Void
        
    func requestSearchPhoto(query: String, completionHandler: @escaping completionHandler) {
        APIService.searchPhoto(query: query, completion: { [weak self] photo, statusCode, error in
//            guard let stautsCode = statusCode, statusCode == 500 else {
//                print(SearchError.serverError)
//                return completionHandler([])
//            }
            if statusCode! != 200 {
                print(SearchError.serverError)
                return completionHandler([])
            }
            
            guard let photo = photo else {
                print(SearchError.noPhoto)
                return completionHandler([])
            }
//            print(photo)
            completionHandler((photo as! SearchPhoto).results)
        })
    }
}
