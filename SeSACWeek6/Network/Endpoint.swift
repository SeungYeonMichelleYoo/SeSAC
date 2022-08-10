//
//  Endpoint.swift
//  SeSACWeek6
//
//  Created by SeungYeon Yoo on 2022/08/08.
//

import Foundation

//바뀌지 않는 값이라 enum
//enum에서 저장프로퍼티는 못쓰고 연산프로퍼티는 쓸 수 있는 이유? (초기화 구문 생성 못하기 때문)
enum Endpoint {
    case blog
    case cafe
   
    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case .cafe:
            return URL.makeEndPointString("cafe?query=")
        }
    }
}

