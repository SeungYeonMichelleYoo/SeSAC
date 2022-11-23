//
//  APIKey.swift
//  SeSAC2Chat
//
//  Created by jack on 2022/11/22.
//

import Foundation

enum APIKey {
    static let url = "http://api.sesac.co.kr:2022/chats" //API문서 : 채팅 보내기
    static let socket = "http://api.sesac.co.kr:2022"
    static let header = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzN2MyYmJkN2JhZDY1M2FjZDMzZmIzNyIsImlhdCI6MTY2OTA4MjA0NSwiZXhwIjoxNjY5MTY4NDQ1fQ.YEXNkzVHbZGfuSoeJKadECqm-JfiD874TmkzjRr5ieU" //회원가입 post로 보내고 끝나면 token값 받아와서 붙여넣음
    static let userId = "637c2bbd7bad653acd33fb37" //내가 보낸거랑 상대방이 보낸걸 구분해주는 수단
}
