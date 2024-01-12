//
//  填充颜色测试demo
//  FillColor.swift
//  FoodPickerTests
//
//  Created by anlythree on 2024/1/6.
//

import SwiftUI

struct FillColor: View {
    var body: some View {
        // ZStack是处理图层的，最先声明的放到最下边，最后声明的放到最上边
        ZStack {
            // 简单直接的填充
            Circle().fill(.yellow)
            // 使用图片填充并规定缩放
            Circle().fill(.image(.init("dinner"),scale: 0.2)).zIndex(1.0)
            // 渐变文字
            Text("Hello")
                .font(.system(size: 100).bold())
                .foregroundStyle(.linearGradient(Gradient(colors: [.pink,.indigo]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .background {
                    Color.bg.scaleEffect(x:1.5,y:1.3)
                    .blur(radius: 20)
                }
        }
    }
}

#Preview {
    FillColor()
}
