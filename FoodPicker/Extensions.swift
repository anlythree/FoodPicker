//
//  Extensions.swift
//  FoodPicker
//
//  Created by anlythree on 2023/12/3.
//

import SwiftUI


// MARK: - StyleFunc
// ⚠️上边抽取View用的extension ContentView，而这里直接用的View
extension View {
    // 主要的按钮风格
    func mainButtonStyle() -> some View {
        
        // .borderedProminent 就是.bordered的效果+背景变成强调色
        buttonStyle(.borderedProminent)
        // 圆角矩形的样式
            .buttonBorderShape(.capsule)
        // 跟控制器相关的画面的大小,这里调成大的，这个不止button可以用
            .controlSize(.large)
    }
    
    // 使用圆角背景 颜色使用系统背景颜色
    func roundRectBackground(radius: CGFloat = 8,
                             fill: some ShapeStyle = .bg) -> some View {
        background(
            RoundedRectangle(cornerRadius: radius).fill(fill))
    }
}

// MARK: - AnimationConfig
extension Animation{
    // 自定义动画曲线
    static let AnlySpring = Animation.spring(dampingFraction: 0.55)
    static let AnlyEase = Animation.easeInOut(duration: 0.7)
}

// MARK: - ColorConfig
// 这种定义方式在用bg和bg2的时候不用Color.bg,只需要直接.bg就可以了
extension ShapeStyle where Self == Color {
    // 颜色
    static var bg: Color{Color(.systemBackground)}
    static var bg2: Color{Color(.secondarySystemBackground)}
}

// MARK: - 进场和离场的动画
extension AnyTransition{
    static let delyInsertionOpacity = Self.asymmetric(
        //进场：淡入淡出，持续0.5秒，延时0.2秒，这个延时的意思是效果延迟0.2秒再显示，也就是效果一直在发生，只是0.2秒之后开始表现出来
        //所以这里整体效果就是前一个食物慢慢消失，后一个食物唰一下显示出来
        insertion: .opacity.animation(.easeInOut(duration: 1).delay(0.2)),
        // 出场：淡入淡出，持续0.5秒
        removal: .opacity.animation(.easeInOut(duration: 0.5))
    )
    
    // 从上边出现并使用一个转动出现的动画
    static let moveUpWithOpacity = Self.move(edge: .top).combined(with: .opacity)
}
