//
//  NewsViewModel.swift
//  SeSAC_CompositionalLayout
//
//  Created by SeungYeon Yoo on 2022/10/20.
//

import Foundation

class NewsViewModel {
    
    var pageNumber: CObservable<String> = CObservable("3000")
    
    //뉴스가 추가되고 제거되는걸 표현
    var dummyNews: CObservable<[News.NewsItem]> = CObservable(News.items)
    
    func changePageNumberFormat(text: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let text = text.replacingOccurrences(of: ",", with: "")
        guard let number = Int(text) else { return }
        let result = numberFormatter.string(for: number)!
        pageNumber.value = result
    }
    
    
    func resetdummyNews() {
        dummyNews.value = []
    }
    
    func loaddummyNews() {
        dummyNews.value = News.items        
    }
}
