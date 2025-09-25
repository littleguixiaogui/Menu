//
//  ContentView.swift
//  Menu
//
//  Created by 相 on 22/09/2025.
//

import SwiftUI


struct FoodItem: Identifiable {
    let id = UUID()
    let name: String
    var isFoodChoose: Bool = false
}

struct DishItem: Identifiable {
    let id = UUID()
    let name: String
    var isDishChoose: Bool = false
}

struct DessertItem: Identifiable {
    let id = UUID()
    let name: String
    var isDessertChoose: Bool = false
}

struct ContentView: View {
    @State private var FoodList:[FoodItem]=[
        FoodItem(name: "米饭"),
        FoodItem(name: "面条")
    ]
    @State private var DishList:[DishItem]=[
        DishItem(name:"青菜"),
        DishItem(name:"红烧肉"),
        DishItem(name:"蒜蓉炒菜"),
    ]
    @State private var DessertList:[DessertItem]=[
        DessertItem(name:"提拉米苏"),
        DessertItem(name: "姜撞奶")
    ]
    
    @State private var showDishlist: Bool = false
    @State private var showFoodlist: Bool = false
    @State private var showDessertList:Bool = false
    @State private var showGoShop:Bool = true
    
    
    var body: some View {
        
        var itemNumber: String{
            let foods=FoodList.filter{$0.isFoodChoose}.count
            let dishes=DishList.filter{$0.isDishChoose}.count
            let desserts=DessertList.filter{$0.isDessertChoose}.count
            return "\(foods)\(dishes)\(desserts)"
        }
        
        HStack{
            VStack{
                Text("主食")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 160, height: 70, alignment: .trailing)
                    .padding(.trailing)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray))
                    .offset(x:showFoodlist ? -50:-90)
                    .onTapGesture {
                        withAnimation {
                            showFoodlist=true
                            showDishlist=false
                            showDessertList=false
                            showGoShop=false
                        }
                    }
                Text("主菜")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 160, height: 70, alignment: .trailing)
                    .padding(.trailing)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray))
                    .offset(x:showDishlist ? -50:-90)
                    .onTapGesture {
                        withAnimation {
                            showFoodlist=false
                            showDishlist=true
                            showDessertList=false
                            showGoShop=false
                        }
                    }
                Text("甜点")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 160, height: 70, alignment: .trailing)
                    .padding(.trailing)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray))
                    .offset(x:showDessertList ? -50:-90)
                    .onTapGesture{
                        withAnimation {
                            showFoodlist=false
                            showDishlist=false
                            showDessertList=true
                            showGoShop=false
                        }
                    }
                Text("结算")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 160, height: 70, alignment: .trailing)
                    .padding(.trailing)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray))
                    .offset(x:showGoShop ? -50:-90)
                    .onTapGesture {
                        withAnimation {
                            showFoodlist=false
                            showDishlist=false
                            showDessertList=false
                            showGoShop=true
                        }
                    }
            }
            Spacer()
            VStack{
                if showFoodlist{
                    VStack{
                        ForEach($FoodList) { $food in
                            HStack{
                                Button{
                                    food.isFoodChoose.toggle()
                                }label:{
                                    Image(systemName:food.isFoodChoose ? "heart.fill":"heart")
                                        .foregroundStyle(.green)
                                        .font(.system(size: 25))
                                    Text(food.name)
                                        .font(.system(size: 25))
                                        .padding()
                                }
                            }
                        }
                    }
                }
                if showDishlist{
                    VStack{
                        ForEach($DishList) { $dish in
                            HStack{
                                Button{
                                    dish.isDishChoose.toggle()
                                    
                                }label:{
                                    Image(systemName:dish.isDishChoose ? "heart.fill":"heart")
                                        .foregroundStyle(.green)
                                        .font(.system(size: 25))
                                    Text(dish.name)
                                        .font(.system(size: 25))
                                        .padding()
                                }
                            }
                        }
                    }
                }
                if showDessertList{
                    VStack{
                        ForEach($DessertList){ $dessert in
                            HStack{
                                Button{
                                    dessert.isDessertChoose.toggle()
                                }label:{
                                    Image(systemName: dessert.isDessertChoose ? "heart.fill" : "heart")
                                        .foregroundStyle(.green)
                                        .font(.system(size: 25))
                                    Text(dessert.name)
                                        .font(.system(size: 25))
                                        .padding()
                                }
                            }
                        }
                    }
                }
                if showGoShop{
                    HStack{
                        Text(itemNumber)
                            .font(.system(size: 25))
                        Button ("结算"){
                            
                        }
                    }
                }
            }
            .padding(.trailing)
        }
    }
}

#Preview {
    ContentView()
}
