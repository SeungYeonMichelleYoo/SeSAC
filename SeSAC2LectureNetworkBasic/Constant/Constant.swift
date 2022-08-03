//
//  Constant.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by SeungYeon Yoo on 2022/08/01.
//

import Foundation

struct APIKey {
    static let BOXOFFICE = "1a2c6b44273f726ddf6c707c9d32a212"
    
    static let NAVER_ID = "P2ycBelQ4_Uvc_bFVaxX"
    static let NAVER_SECRET = "LMNEQvP0_w"
}

struct EndPoint {
    static let boxOfficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
    static let imageSearchURL = "https://openapi.naver.com/v1/search/image.json?"
}

//enum StoryboardName: String {
//    case Main
//    case Search
//    case Setting
//}

//StoryboardName.Main.rawvalue

//struct StoryboardName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

//StoryboardName.search

struct StoryboardName {
    //접근제어를 통해 초기화 방지
    //다른 파일에서 접근 불가. 이 파일에서만 접근 가능.
    private init() {
        
    }
        
    static var main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

//enum안에 type프로퍼티를 쓸 때의 장점
//1.struct type property vs. enum type property => 인스턴스 생성 방지 (어느정도 막아놓음 vs. 완전 강제로 인스턴스 생성 막아놓음) -> 단, struct 에 private init()을 쓰면 다른 파일에서 인스턴스 생성을 막아놓을 수 있다.
//열거형은 초기화가 안됨. VC에서 사용하고 싶더라도 인스턴스 생성 방지라서 안됨.


//2. enum case vs. enum static => 중복된 내용을 하드코딩할 수 있냐 없냐 / case 제약
enum FontName {
    static let title = "SanFransisco"
    static let body = "SanFransisco"
    static let caption = "AppleSandol"
}
