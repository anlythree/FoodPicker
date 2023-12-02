//
//  PreviewDevice.swift
//  FoodPicker
//
//  Created by anlythree on 2023/11/27.
//

import SwiftUI

// 定义不同的设备
extension PreviewDevice{
    // 这里的设备名称一定要敲对，这个跟xcode上边的设备选择里要一样，必须是在那个列表里一摸一样存在的名字
    static let iPad = PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)")
    static let iphoneSE = PreviewDevice(rawValue: "iPhone SE (3rd generation)")
}
