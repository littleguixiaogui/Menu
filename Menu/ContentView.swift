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


struct ExpandingPillButton: View {
    let title: String
    let systemImage: String
    let isActive: Bool
    let action: () -> Void
    @Namespace private var ns

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 32, height: 32)
                    .background(Circle().fill(isActive ? Color.accentColor.opacity(0.15) : Color.secondary.opacity(0.12)))
                    .overlay(Circle().stroke(Color.white.opacity(0.2)))
                    .matchedGeometryEffect(id: "icon-\(title)", in: ns)

                if isActive {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .transition(.opacity.combined(with: .move(edge: .leading)))
                        .matchedGeometryEffect(id: "label-\(title)", in: ns)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, isActive ? 14 : 6)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(isActive ? Color.accentColor.opacity(0.6) : Color.white.opacity(0.2), lineWidth: isActive ? 2 : 1)
            )
            .shadow(color: Color.black.opacity(isActive ? 0.18 : 0.08), radius: isActive ? 10 : 6, x: 0, y: isActive ? 6 : 3)
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: isActive)
    }
}

struct SelectableRow: View {
    let title: String
    @Binding var isSelected: Bool
    var tint: Color = .green
    var textColor: Color? = nil
    var spacing: CGFloat = 12

    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            HStack(spacing: spacing) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(isSelected ? tint : tint.opacity(0.7))
                    .frame(width: 28, height: 28)

                Text(title)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(textColor ?? .primary)

                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.08))
            )
            .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
        .animation(.spring(response: 0.3, dampingFraction: 0.85), value: isSelected)
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
        DishItem(name:"蒜蓉炒菜",dishIngredient: ["蒜","青菜"]),
    ]
    @State private var DessertList:[DessertItem]=[
        DessertItem(name:"提拉米苏",dessertIngredient: ["芝士🧀","拇指饼干","鸡蛋","柠檬","糖","咖啡"]),
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
        
        TabView {
            // 菜单
            VStack{
                Spacer()
                HStack{
                    VStack(alignment: .leading, spacing: 12) {
                        ExpandingPillButton(title: "主食", systemImage: "takeoutbag.and.cup.and.straw", isActive: showFoodlist) {
                            withAnimation {
                                showFoodlist = true
                                showDishlist = false
                                showDessertList = false
                                showRelishList = false
                                showGoShop = false
                            }
                        }
                        ExpandingPillButton(title: "主菜", systemImage: "fork.knife", isActive: showDishlist) {
                            withAnimation {
                                showFoodlist = false
                                showDishlist = true
                                showDessertList = false
                                showRelishList = false
                                showGoShop = false
                            }
                        }
                        ExpandingPillButton(title: "甜点", systemImage: "apple.logo", isActive: showDessertList) {
                            withAnimation {
                                showFoodlist = false
                                showDishlist = false
                                showDessertList = true
                                showRelishList = false
                                showGoShop = false
                            }
                        }
                        ExpandingPillButton(title: "柴米油盐", systemImage: "leaf", isActive: showRelishList) {
                            withAnimation {
                                showFoodlist = false
                                showDishlist = false
                                showDessertList = false
                                showRelishList = true
                                showGoShop = false
                            }
                        }
                        ExpandingPillButton(title: "购物车", systemImage: "cart", isActive: showGoShop) {
                            withAnimation {
                                showFoodlist = false
                                showDishlist = false
                                showDessertList = false
                                showRelishList = false
                                showGoShop = true
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 180, alignment: .leading)
                    Spacer()
                    VStack{
                        if showFoodlist {
                            ScrollView {
                                LazyVStack(spacing: 10) {
                                    ForEach($FoodList) { $food in
                                        SelectableRow(title: food.name, isSelected: $food.isFoodChoose, tint: .green)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            Spacer()
                        }
                        if showDishlist {
                            ScrollView {
                                LazyVStack(spacing: 10) {
                                    ForEach($DishList) { $dish in
                                        SelectableRow(title: dish.name, isSelected: $dish.isDishChoose, tint: .green)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            Spacer()
                        }
                        if showDessertList {
                            ScrollView {
                                LazyVStack(spacing: 10) {
                                    ForEach($DessertList) { $dessert in
                                        SelectableRow(title: dessert.name, isSelected: $dessert.isDessertChoose, tint: .green)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            Spacer()
                        }
                        
                        if showRelishList {
                            ScrollView {
                                LazyVStack(spacing: 10) {
                                    ForEach($RelishList) { $relish in
                                        SelectableRow(title: relish.name, isSelected: $relish.isRelishChoose, tint: .green)
                                    }
                                }
                                .padding(.vertical, 4)
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
            .tabItem {
                Image(systemName: "menucard")
                Text("菜单")
            }
            .tag(0)
            
            // 清单
            ScrollView {
                if ingredientList.isEmpty {
                    Text("暂无食材")
                        .font(.system(size: 22))
                        .foregroundStyle(.secondary)
                        .padding()
                } else {
                    LazyVStack(spacing: 10) {
                        // Count occurrences of each ingredient
                        let counts = ingredientList.reduce(into: [String: Int]()) { partial, item in
                            partial[item, default: 0] += 1
                        }
                        // Preserve the order of first appearance
                        var seen = Set<String>()
                        let uniqueIngredients = ingredientList.filter { seen.insert($0).inserted }

                        ForEach(uniqueIngredients, id: \.self) { ingredient in
                            let count = counts[ingredient] ?? 1
                            let displayName = count > 1 ? "\(ingredient) x\(count)" : ingredient

                            let binding = Binding<Bool>(
                                get: { ingredientPickUp.contains(ingredient) },
                                set: { newValue in
                                    if newValue {
                                        ingredientPickUp.insert(ingredient)
                                    } else {
                                        ingredientPickUp.remove(ingredient)
                                    }
                                }
                            )

                            SelectableRow(
                                title: displayName,
                                isSelected: binding,
                                tint: .accentColor,
                                textColor: ingredientPickUp.contains(ingredient) ? .primary : .secondary,
                                spacing: 16
                            )
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "list.bullet.clipboard")
                Text("清单")
            }
            .tag(1)
        }
    }
}

#Preview {
    ContentView()
}

