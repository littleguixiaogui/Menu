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

struct RelishItem: Identifiable {
    let id = UUID()
    let name: String
    var isRelishChoose: Bool = false
    let relishIngredient: [String]
}


struct MenuButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    //menu button
    var body: some View{
        Text(title)
            .font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(width: 140, height: 120, alignment: .trailing)
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
        DessertItem(name:"提拉米苏",dessertIngredient: ["芝士🧀","拇指饼干","鸡蛋","柠檬","糖","柠檬","咖啡"]),
        DessertItem(name: "姜撞奶",dessertIngredient: ["姜","奶"])
    ]
    @State private var RelishList:[RelishItem]=[
        RelishItem(name:"葱",relishIngredient: ["葱"]),
        RelishItem(name:"葱白",relishIngredient: ["葱白"]),
        RelishItem(name:"姜",relishIngredient: ["姜"]),
        RelishItem(name:"蒜",relishIngredient: ["蒜"]),
        RelishItem(name:"醋",relishIngredient: ["醋"]),
        RelishItem(name:"生抽",relishIngredient: ["生抽"]),
        RelishItem(name:"老抽",relishIngredient: ["老抽"]),
        RelishItem(name:"油",relishIngredient: ["油"]),
        RelishItem(name:"黄油",relishIngredient:["黄油"]),
        RelishItem(name:"盐",relishIngredient: ["盐"]),
        RelishItem(name:"糖",relishIngredient: ["糖"]),
    ]
    
    
    
    @State private var showMainMenu: Bool = true
    @State private var showListMenu: Bool = false
    
    
    @State private var showDishlist: Bool = false
    @State private var showFoodlist: Bool = false
    @State private var showDessertList:Bool = false
    @State private var showRelishList:Bool = false
    @State private var showGoShop:Bool = true
    
   
    @State private var ingredientPickUp: Set<String>=[]
    
    
    var body: some View {
        
        var itemNumber: String{
            let foods=FoodList.filter{$0.isFoodChoose}.count
            let dishes=DishList.filter{$0.isDishChoose}.count
            let desserts=DessertList.filter{$0.isDessertChoose}.count
            let relishes=RelishList.filter{$0.isRelishChoose}.count
            return "\(foods)\(dishes)\(desserts)\(relishes)"
        }
        
        var ingredientList: [String] {
            let foodIngredientList=FoodList.filter{$0.isFoodChoose}.flatMap{$0.foodIngredient}
            let dishIngredientList=DishList.filter{$0.isDishChoose}.flatMap{$0.dishIngredient}
            let dessertIngredientList=DessertList.filter{$0.isDessertChoose}.flatMap{$0.dessertIngredient}
            let relishIngredientList=RelishList.filter{$0.isRelishChoose}.flatMap{$0.relishIngredient}
            return foodIngredientList+dishIngredientList+dessertIngredientList+relishIngredientList
        }
        
        VStack{
            HStack{
                Button{
                    withAnimation{
                        showMainMenu=true
                        showListMenu=false
                    }
                }label:{
                    HStack{
                        
                        Image(systemName: "menucard")
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                    }
                    .frame(width: 160, height: 70)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray))
                }
                Spacer()
                Button{
                    withAnimation{
                        showMainMenu=false
                        showListMenu=true
                    }
                }label:{
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                            .foregroundStyle(.white)
                            .font(.system(size: 30))

                    }
                    .frame(width: 160, height: 70)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray))
                }
                
            }
            .padding(.leading)
            .padding(.trailing)
            Spacer()
            VStack{
                //showMainMenu
                if showMainMenu{
                    Spacer()
                    HStack{
                        VStack{
                            MenuButton(title:"主\n食",isActive: showFoodlist){
                                withAnimation {
                                    showFoodlist=true
                                    showDishlist=false
                                    showDessertList=false
                                    showRelishList=false
                                    showGoShop=false
                                }
                            }
                            MenuButton(title:"主\n菜",isActive: showDishlist){
                                withAnimation {
                                    showFoodlist=false
                                    showDishlist=true
                                    showDessertList=false
                                    showRelishList=false
                                    showGoShop=false
                                }
                            }
                            MenuButton(title:"甜\n点",isActive: showDessertList){
                                withAnimation {
                                    showFoodlist=false
                                    showDishlist=false
                                    showDessertList=true
                                    showRelishList=false
                                    showGoShop=false
                                }
                            }
                            
                            MenuButton(title:"柴\n米\n油\n盐",isActive: showRelishList){
                                withAnimation{
                                    showFoodlist=false
                                    showDishlist=false
                                    showDessertList=false
                                    showRelishList=true
                                    showGoShop=false
                                }
                            }
                            
                            MenuButton(title:"购\n物\n车",isActive: showGoShop){
                                withAnimation {
                                    showFoodlist=false
                                    showDishlist=false
                                    showDessertList=false
                                    showRelishList=false
                                    showGoShop=true
                                }
                            }
                            Spacer()
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
                                                Image(systemName:food.isFoodChoose ? "rectangle.portrait.fill":"rectangle.portrait")
                                                    .foregroundStyle(.green)
                                                    .font(.system(size: 25))
                                                Text(food.name)
                                                    .font(.system(size: 25))
                                                    .padding()
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            if showDishlist{
                                VStack{
                                    ForEach($DishList) { $dish in
                                        HStack{
                                            Button{
                                                dish.isDishChoose.toggle()
                                            }label:{
                                                Image(systemName:dish.isDishChoose ? "rectangle.portrait.fill":"rectangle.portrait")
                                                    .foregroundStyle(.green)
                                                    .font(.system(size: 25))
                                                Text(dish.name)
                                                    .font(.system(size: 25))
                                                    .padding()
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            if showDessertList{
                                VStack{
                                    ForEach($DessertList){ $dessert in
                                        HStack{
                                            Button{
                                                dessert.isDessertChoose.toggle()
                                            }label:{
                                                Image(systemName: dessert.isDessertChoose ? "rectangle.portrait.fill" : "rectangle.portrait")
                                                    .foregroundStyle(.green)
                                                    .font(.system(size: 25))
                                                Text(dessert.name)
                                                    .font(.system(size: 25))
                                                    .padding()
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            
                            if showRelishList{
                                ScrollView{
                                    VStack{
                                        ForEach($RelishList) { $relish in
                                            HStack{
                                                Button{
                                                    relish.isRelishChoose.toggle()
                                                }label:{
                                                    Image(systemName: relish.isRelishChoose ? "rectangle.portrait.fill" : "rectangle.portrait")
                                                        .foregroundStyle(.green)
                                                        .font(.system(size: 25))
                                                    Text(relish.name)
                                                        .font(.system(size: 25))
                                                        .padding()
                                                }
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            
                            if showGoShop{
                                VStack{
                                    Text(itemNumber)
                                        .font(.system(size: 25))
                                    Button("结算"){
                                        
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
                                            Button{
                                                if ingredientPickUp.contains(ingredient){
                                                    ingredientPickUp.remove(ingredient)
                                                }else{
                                                    ingredientPickUp.insert(ingredient)
                                                }
                                            }label:{
                                                Image(systemName:ingredientPickUp.contains(ingredient) ? "rectangle.portrait.fill" : "rectangle.portrait")
                                                    .foregroundStyle(.red)
                                                    .font(.system(size: 25))
                                                Spacer()
                                                Text(ingredient)
                                            }
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
