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
        DishItem(name:"土豆丝changing just for github repo test")
    ]
    @State private var DessertList:[DessertItem]=[
        DessertItem(name:"empty")
    ]
    
    @State private var showDishlist: Bool = false
    @State private var showFoodlist: Bool = false
    @State private var showDessert:Bool = false
    @State private var showGoShop:Bool = false
    
    var body: some View {
        //main food
        VStack{
            VStack{
                Text("主菜")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 250, height: 90)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray)
                    )
                    .padding()
                    .onTapGesture {
                        withAnimation{
                            
                            showFoodlist=false
                            showDishlist=true
                            showDessert=false
                            showGoShop=false
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
                
            }
            //main dish
            VStack{
                Text("主食")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 250, height: 90)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray)
                    )
                    .padding()
                    .onTapGesture {
                        withAnimation{
                            
                            showFoodlist=true
                            showDishlist=false
                            showDessert=false
                            showGoShop=false
                        }
                        
                    }
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
                
            }
            
            //dessert
            VStack{
                Text("甜点")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 250, height: 90)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray)
                    )
                    .padding()
                    .onTapGesture{
                        withAnimation {
                            showFoodlist=false
                            showDishlist=false
                            showDessert=true
                            showGoShop=false
                        }
                    }
                if showDessert{
                    VStack{
                        Text("Empty for now")
                    }
                }
            }
        }
            
        //check out button
        VStack{
            Text("购物车")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 250, height: 90)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray)
                    
                )
                .padding()
                .onTapGesture {
                    withAnimation{
                        showFoodlist=false
                        showDishlist=false
                        showDessert=false
                        showGoShop=true
                    }
                }
            var chooseItems: [String]{
                let foods=FoodList.filter{$0.isFoodChoose}.map{$0.name}
                let dishes=DishList.filter{$0.isDishChoose}.map{$0.name}
                let desserts=DessertList.filter{$0.isDessertChoose}.map{$0.name}
                return foods+dishes+desserts
            }
            if showGoShop{
                VStack{
                    if chooseItems.isEmpty{
                        Text("购物车是空的")
                            .font(.system(size: 25))
                    }else{
                        HStack{
                            ForEach(chooseItems, id: \.self) { item in
                                Text(item)
                                    .font(.system(size: 25))
                                
                            }
                        }
                        
                    }
                }

            }
        }
    }

}

#Preview {
    ContentView()
}
