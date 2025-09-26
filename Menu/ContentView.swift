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
    let foodIngredient: [String]
}

struct DishItem: Identifiable {
    let id = UUID()
    let name: String
    var isDishChoose: Bool = false
    let dishIngredient: [String]
}

struct DessertItem: Identifiable {
    let id = UUID()
    let name: String
    var isDessertChoose: Bool = false
    let dessertIngredient: [String]
}



struct TopButton: View {
    let topTitle: String
    let buttonActive: Bool
    let buttonAction: () -> Void
    
    var body: some View {
        Text(topTitle)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(width: 160, height: 70)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray))
            .onTapGesture {
                buttonAction()
            }
    }
}

struct MenuButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    //menu button
    var body: some View{
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(width: 160, height: 70, alignment: .trailing)
            .padding(.trailing)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray))
            .offset(x:isActive ? -50:-90)
            .onTapGesture {
                withAnimation {
                    action()
                }
            }
    }
}


struct ContentView: View {
    @State private var FoodList:[FoodItem]=[
        FoodItem(name: "米饭",foodIngredient:["米饭"]),
        FoodItem(name: "面条",foodIngredient:["面条"])
    ]
    @State private var DishList:[DishItem]=[
        DishItem(name:"青菜",dishIngredient: ["青菜"]),
        DishItem(name:"红烧肉",dishIngredient: ["五花肉"]),
        DishItem(name:"蒜蓉炒菜",dishIngredient: ["蒜蓉","青菜"]),
    ]
    @State private var DessertList:[DessertItem]=[
        DessertItem(name:"提拉米苏",dessertIngredient: ["提","拉","米","苏",]),
        DessertItem(name: "姜撞奶",dessertIngredient: ["姜","奶"])
    ]
    
    
    
    
    @State private var showMainMenu: Bool = true
    @State private var showListMenu: Bool = false
    
    
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
        
        var ingredientList: [String] {
            let foodIngredientList=FoodList.filter{$0.isFoodChoose}.flatMap{$0.foodIngredient}
            let dishIngredientList=DishList.filter{$0.isDishChoose}.flatMap{$0.dishIngredient}
            let dessertIngredientList=DessertList.filter{$0.isDessertChoose}.flatMap{$0.dessertIngredient}
            return foodIngredientList+dishIngredientList+dessertIngredientList
        }
        
        VStack{
            Spacer()
            HStack{
                TopButton(topTitle:"主页",buttonActive:showMainMenu){
                    withAnimation{
                        showMainMenu=true
                        showListMenu=false
                    }
                }
                
                Spacer()
                TopButton(topTitle:"列表",buttonActive:showListMenu){
                    withAnimation{
                        showMainMenu=false
                        showListMenu=true
                    }
                }
                
            }
            .padding()
            Spacer()
            VStack{
                //showMainMenu
                if showMainMenu{
                    Spacer()
                    HStack{
                        VStack{
                            MenuButton(title:"主食",isActive: showFoodlist){
                                withAnimation {
                                    showFoodlist=true
                                    showDishlist=false
                                    showDessertList=false
                                    showGoShop=false
                                }
                            }
                            MenuButton(title:"主菜",isActive: showDishlist){
                                withAnimation {
                                    showFoodlist=false
                                    showDishlist=true
                                    showDessertList=false
                                    showGoShop=false
                                }
                            }
                            MenuButton(title:"甜点",isActive: showDessertList){
                                withAnimation {
                                    showFoodlist=false
                                    showDishlist=false
                                    showDessertList=true
                                    showGoShop=false
                                }
                            }
                            MenuButton(title:"结算",isActive: showGoShop){
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
                                VStack{
                                    Text(itemNumber)
                                        .font(.system(size: 25))
                                    Button ("结算"){
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    Spacer()
                }
                
                if showListMenu{
 
                    ScrollView{
                        HStack{
                            VStack{
                                if ingredientList.isEmpty{
                                    Text("暂无食材")
                                        .font(.system(size: 25))
                                        .padding()
                                }else{
                                    Spacer()
                                    ForEach(ingredientList, id: \.self) { ingredient in
                                        HStack{
                                            Text("icon")
                                            Spacer()
                                            Text(ingredient)
                                        }
                                    }
                                    .font(.system(size: 25))
                                    .padding()
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
