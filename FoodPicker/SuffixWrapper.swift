//
//  SuffixWrapper.swift
//  FoodPicker
//
//  Created by anlythree on 2023/12/3.
//

import SwiftUI

// 相当于定义了一个@注解
@propertyWrapper struct Suffix : Equatable{
    var wrappedValue: Double
    private var suffix: String
    
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
    // 可以使用$来调用
    var projectedValue: String{
        wrappedValue.formatted() + " \(suffix)"
    }
}
