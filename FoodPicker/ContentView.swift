//
//  ContentView.swift
//  FoodPicker
//
//  Created by anlythree on 2023/11/19.
//

import SwiftUI

// View 是一个Protocol,只要实现了View就可以在页面上显示
// View定义的唯一要求就是需要定义一个body属性，里边会描述这个view会长什么样子
struct ContentView: View { 
    // 可选择的食物列表
    let foodList = ["汉堡🍔","炸鸡🍗","薯条🍟","奶油蘑菇浓汤🍲","吃土"]
    // 被选择的食物
    // @State注解：swift在struct中不能修改自己的属性，所以需要创建一个Class，在Class中维护selectedFood，而且目前我们还需要selectedfood变动的时候通知ContentView。所以swift为了方便这种场景封装了State注解来完成上边说的那些事情。
    // 我们大概可以认为要在一个struct中修改的变量就需要加上State注解
    @State var selectedFood: String?
    
    // 最外层的View
    var body: some View {
        // 这里的spacing：30 是相当于给这个VStack里的每一个元素都加了个30的padding
        VStack(spacing: 30) {
            Image("dinner")
            // 可以被重新设置大小
                .resizable()
            // fit就是swift自动找到一个合适的大小
                .aspectRatio(contentMode: .fit)
            
            Text("今天吃什么?")
            // 设置成最大字体
            // 字体加粗
                .bold()
            if(selectedFood != .none){
                // 只有当选中食物不为空的时候才显示选择的食物
                Text(selectedFood ?? "？？？")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                    //设置id是一个技巧，这样id不同swift就会认为是不同的view然后使用转场效果，而不是变形
                    //不设置id的话这个TextView会根据不同的ios版本的规则表现出不一样的效果，这样很不好
                    .id(selectedFood)
                    // 这个效果很难看，哈哈，这里只是做个演示
                    //.scale是表示逐渐变大，combined是表示从左边滑出.所以整个效果是从左边一边变大一边滑出
                    // 而且再点击，会从右边一边变小一边从右边滑出
//                    .transition(.scale.combined(with: .slide))
                    // 当然进场和出场动画可以分别设置
                    .transition(.asymmetric(
                        //进场：淡入淡出，持续0.5秒，延时0.2秒，这个延时的意思是效果延迟0.2秒再显示，也就是效果一直在发生，只是0.2秒之后开始表现出来
                        //所以这里整体效果就是前一个食物慢慢消失，后一个食物唰一下显示出来
                        insertion: .opacity.animation(.easeInOut(duration: 1).delay(0.2)),
                        // 出场：淡入淡出，持续0.5秒
                        removal: .opacity.animation(.easeInOut(duration: 0.5))
                    ))
            }
            
            // 选择按钮
            Button(role: .none) {
                // 当没有.animation的预设动画方案的时候，只有被withAnimation代码
                // 从被打乱顺序的foodList中取一个跟当前选择不一样的元素
                selectedFood = foodList.shuffled().first{ $0 != selectedFood}
            } label: {
                Text(selectedFood == .none ? "告诉我" : "换一个")
                    .frame(width: 200)
                    
            }.transformEffect(.identity)
            // .bordered就是加一个padding的效果成一个圆角矩形
                .padding(.bottom, -15)
            
            // 重制按钮
            Button(role: .none) {
                selectedFood = .none
            } label: {
                Text("重制").frame(width: 200)
            }.transformEffect(.identity)
            // 重制按钮不需要很强调，这样一看到页面就会把目光聚焦在"告诉我"的按钮上
                .buttonStyle(.bordered)
        }
        .padding()
        // frame设置：一些限制，比如这里显示高度为无穷大
        .frame(maxHeight: .infinity)
        //加上这个背景，白色的图片的外边才会显示出来，要不然白色的背景的图片的背景就重合了
        .background(Color(.secondarySystemBackground))
        .font(.title)
        // 这里可以设置VStack的默认字体格式
        // .borderedProminent 就是.bordered的效果+背景变成强调色
        .buttonStyle(.borderedProminent)
        // 圆角矩形的样式
        .buttonBorderShape(.capsule)
        // 跟控制器相关的画面的大小,这里调成大的，这个不止button可以用
        .controlSize(.large)
        //设置当selectedFood发生变化的时候，所有包含相关的view会自动产生一些动画。相当于一个预设的动画方案
        // duration是持续的意思，这里就是设置动画持续的时间,
        .animation(.easeInOut(duration: 0.7),value: selectedFood)
    }
}

#Preview {
    ContentView()
}
