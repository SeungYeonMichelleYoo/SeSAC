//
//  CObservable.swift
//  SeSAC_CompositionalLayout
//
//  Created by SeungYeon Yoo on 2022/10/20.
//

import Foundation

/*
 Observable
 */

class CObservable<T> {
    private var listener: ((T) -> Void)?
    
    var value: T { //데이터가 바뀌면
        didSet {
            listener?(value) // listener가 실행된다
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
    
}
