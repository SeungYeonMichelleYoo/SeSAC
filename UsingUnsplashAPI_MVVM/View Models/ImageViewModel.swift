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
    
    typealias completionHandler = ([SearchResult], Int, Int) -> Void
        
    func requestSearchPhoto(query: String, page: Int, completionHandler: @escaping completionHandler) {
        APIService.searchPhoto(query: query, indexPage: page, completion: { [weak self] photo, statusCode, error in
            if statusCode! != 200 {
                print(SearchError.serverError)
                return completionHandler([], 0, 0)
            }
            guard let photo = photo else {
                print(SearchError.noPhoto)
                return completionHandler([], 0, 0)
            }
            completionHandler((photo as! SearchPhoto).results, (photo as! SearchPhoto).totalPages, (photo as! SearchPhoto).total)
        })
    }
}
