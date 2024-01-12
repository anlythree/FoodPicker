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
    
    // @State注解：swift在struct中不能修改自己的属性，所以需要创建一个Class，在Class中维护selectedFood，而且目前我们还需要selectedfood变动的时候通知ContentView。所以swift为了方便这种场景封装了State注解来完成上边说的那些事情。
    // 我们大概可以认为要在一个struct中修改的变量就需要加上State注解
    @State private var selectedFood: Food?
    // 是否显示营养信息
    @State private var shouldShowNutrition: Bool = false
    
    // 可选择的食物列表
    let foodList : Array<Food> = Food.foodExampleList
    // 被选择的食物 最外层的View
    var body: some View {
        // scrollview就是一个带滚动条的view，这里可以用来适配小屏手机显示不全画面的问题
        ScrollView{
            // 这里的spacing：30 是相当于给这个VStack里的每一个元素都加了个30的padding
            VStack(spacing: 30) {
                // 顶上的食物图片
                foodImageOnTopView
                
                Text("今天吃什么?").bold()
                
                selectFoodInfoView
                //用来占满View的剩余空间，防止底下的按钮总是动，以至于连续点换一个可能点到重制按钮
                //.layoutPriority(1)用来把排版优先级设置大于上边的Hstack这样swift会优先考虑Spacer的排版，就不会把Hstack拉长了
                Spacer().layoutPriority(1)
                
                // 选择按钮
                selectFoodButton
                
                // 重制按钮
                cancelFoodButton
            }
            .padding()
            //frame设置：因为Vstack的排版类型是Neutral，所以需要里边的子View来决定要多大，这里宽度设置成无穷大，这样下边的背景图才会占满全屏。高度不用设置成最大的，因为scrollView本来就可以把高度拉到最大
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            //加上这个背景，白色的图片的外边才会显示出来，要不然白色的背景的图片的背景就重合了
            // 这里可以设置VStack的默认字体格式
            .font(.title)
            .mainButtonStyle()
            //设置当selectedFood发生变化的时候，所有包含相关的view会自动产生一些动画。相当于一个预设的动画方案
            // duration是持续的意思，这里就是设置动画持续的时间,
            .animation(.AnlySpring, value: shouldShowNutrition)
            .animation(.AnlyEase, value: selectedFood)
            //这里不能直接bgColor是因为background需要的是一个ShapeStyle，而Color只是ShapeStyle的一种，所以这里要明确告诉background方法是从Color中找bgColor
        }.background(.bg)
    }
    
}

// MARK: - SubViews
private extension ContentView{
    // 顶上的食物图片
    var foodImageOnTopView: some View{
        // Group是一个特殊的view，他可以给里边的view赋予同样的调整器
        Group{
            if(selectedFood == nil){
                Image("dinner")
                // 可以被重新设置大小,而且加了resizable的图片会尝试撑满整个画面
                    .resizable()
                // fit就是swift自动找到一个合适的大小
                    .aspectRatio(contentMode: .fit)
            }else{
                Text(selectedFood!.image)
                    .font(.system(size: 200))
                //有一些image是由两个emoj组成的，后边的emoj放不开swift会默认给缩放成…这样很难看，所以需要用到这个调整器，来设置如果排不开的话缩放多少
                    .minimumScaleFactor(0.7)
                //但是这样调整完之后两个emoj分成了两行，变成了上下排列，所以需要下边这个调整器来告诉swift最多用几行来显示
                    .lineLimit(1)
                // 固定id，告诉swift这是不同的view来达到淡入淡出的效果，而不是时不时触发变形动画
                    .id(selectedFood?.name)
            }
        }.frame(height: 250)
        // 在开发的时候显示边界，方便自己判断view的大小边界
        //                .border(.blue)
        
    }
    
    // 选中食物信息
    @ViewBuilder var selectFoodInfoView: some View{
        if(selectedFood != nil){
            // 显示选中食物信息
            foodNameView
            
            // formattend()方法可以把double多余的小数点去掉
            Text("热量\(selectedFood!.$calorie)")
            
            // 显示选中食物营养信息
            foodNutritionView
        }
    }
    
    // 选中食物名称
    var foodNameView: some View{
        HStack{
            // 只有当选中食物不为空的时候才显示选择的食物
            Text(selectedFood?.name ?? "？？？")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.green)
            Button {
                // toggle()方法是把这个布尔值换成相反的
                shouldShowNutrition.toggle()
            } label: {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.secondary)
                // .plain风格就是没有风格的意思（plain这个单词本意是朴素）
            }.buttonStyle(.plain)
            
        }//设置id是一个技巧，这样id不同swift就会认为是不同的view然后使用转场效果，而不是变形
        //不设置id的话这个TextView会根据不同的ios版本的规则表现出不一样的效果，这样很不好
        .id(selectedFood?.name)
        // 这个效果很难看，哈哈，这里只是做个演示
        //.scale是表示逐渐变大，combined是表示从左边滑出.所以整个效果是从左边一边变大一边滑出
        // 而且再点击，会从右边一边变小一边从右边滑出
        //                    .transition(.scale.combined(with: .slide))
        // 当然进场和出场动画可以分别设置
        .transition(.delyInsertionOpacity)
    }
    
    // 选中食物营养信息
    var foodNutritionView: some View{
        // 使用Grid来实现营养信息展示
        VStack{
            if shouldShowNutrition {
                Grid(horizontalSpacing: 15, verticalSpacing: 12){
                    GridRow{
                        Text("蛋白质")
                        Text("脂肪")
                        Text("碳水")
                    }.frame(minWidth: 60)
                    // 默认的grid只提供了加水平分割线的方法
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                    // 让边框缩小，为了让分割线更长
                        .padding(.horizontal, -3)
                    GridRow{
                        Text(selectedFood!.$protein)
                        Text(selectedFood!.$fat)
                        Text(selectedFood!.$carb)
                    }
                }.font(.title3)
                    .padding(15)
                // 各营养指标 背景的圆角和颜色的设置
                    .roundRectBackground()
                    .transition(.moveUpWithOpacity)
            }
            
        }
        // 加frame的作用就是告诉下边的clipped()函数，左右的大小不用变，只需要从上到下滑出
        .frame(maxWidth: .infinity)
        //这里用Vstack包裹起来并且加上.clipped()的含义是裁减到边界框架。不让动画超出他占用空间的范围
        .clipped()
    }
    
    // 选择按钮
    var selectFoodButton: some View{
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
    }
    
    // 重制按钮
    var cancelFoodButton: some View{
        Button(role: .none) {
            selectedFood = .none
            shouldShowNutrition = false
        } label: {
            Text("重制").frame(width: 200)
        }.transformEffect(.identity)
        // 重制按钮不需要很强调，这样一看到页面就会把目光聚焦在"告诉我"的按钮上
            .buttonStyle(.bordered)
    }
    
}

// MARK: - PreViewConfig
// 如果希望设置我们的预设的初始状态，可以通过这种方式来做，这样可以方便我们观察预设画面的效果
// 这里使用extension来影响预设的启动，如果直接用struct就会覆盖原本预设的
// 下边的#Preview也需要改
extension ContentView{
    init(selectedFood: Food){
        //带下划线的这个变量就是上边第18行使用@State注解定义的那个变量的一个变量，这个变量的修改会影响原本变量的值，可以认为它是一个factory对象吧
        _selectedFood = State(wrappedValue: selectedFood)
    }
}

// 配合上边的extension来实现自己想要的初始的预览效果
//#Preview {
//    ContentView(selectedFood: Food.foodExampleList.first!)
//    // 开一个新的预览画面，设置成ipad
//     ContentView(selectedFood:d Food.foodExampleList.first!).previewDevice(.ipad)
//}
// 这样可以同时开启两个预览画面
struct ContentView_previews: PreviewProvider{
    static var previews: some View{
            ContentView(selectedFood: Food.foodExampleList.first!)
            // 开一个新的预览画面，设置成ipad
             ContentView(selectedFood: Food.foodExampleList.first!).previewDevice(.iPad)
        // 开一个新的预览画面，设置成se：
        ContentView(selectedFood: Food.foodExampleList.first!).previewDevice(.iphoneSE)
    }
}
