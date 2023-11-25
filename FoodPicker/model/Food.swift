//
//  File.swift
//  FoodPicker
//
//  Created by anlythree on 2023/11/25.
//

struct Food : Equatable{
    var name: String
    var image: String
    // 卡路里
    var calorie: Double
    // carb在食物领域表示碳水化合物
    var carb: Double
    // 脂肪
    var fat:Double
    // 蛋白质
    var protein:Double
    
    static let foodExampleList : Array<Food> = [
        Food(name: "汉堡", image: "🍔", calorie: 294, carb: 14, fat: 24, protein: 17),
        Food(name: "沙拉", image: "🥗", calorie: 89, carb: 20, fat: 0, protein: 1.8),
        Food(name: "披萨", image: "🍕", calorie: 266, carb: 33, fat: 10, protein: 11),
        Food(name: "意大利面", image: "🍝", calorie: 339, carb: 74, fat: 1.1, protein: 12),
        Food(name: "鸡腿便当", image: "🍗🍱", calorie: 191, carb: 19, fat: 8.1, protein: 11.7),
        Food(name: "刀削面", image: "🍜", calorie: 256, carb: 56, fat: 1, protein: 8),
        Food(name: "火锅", image: "🍲", calorie: 233, carb: 26.5, fat: 17, protein: 22),
        Food(name: "牛肉面", image: "🐮🍜", calorie: 219, carb: 33, fat: 5, protein: 9),
        Food(name: "关东煮", image: "🍢", calorie: 80, carb: 4, fat: 4, protein: 6),
    ]
}
