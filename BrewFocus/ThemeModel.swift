//
//  ThemeModel.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 4/5/25.
//

import SwiftUI

struct Theme: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let primaryColor: Color
    let backgroundColor: Color
}

struct Themes {
    static let all: [Theme] = [
        Theme(name: "Matcha", emoji: "🍵", primaryColor: Color("MatchaBackground"), backgroundColor: Color("MatchaBackground")),
        Theme(name: "Espresso", emoji: "☕️", primaryColor: Color("EspressoBackground"), backgroundColor: Color("EspressoBackground")),
        Theme(name: "Latte", emoji: "🥛", primaryColor: Color("CoffeeBrown"), backgroundColor: Color("LatteBeige")),
        Theme(name: "Redbull", emoji: "🛸", primaryColor: .blue, backgroundColor: .red),
        Theme(name: "Pink Drink", emoji: "🌸", primaryColor: Color.pink, backgroundColor: Color("PinkDrinkBackground")),
        Theme(name: "Water", emoji: "💧", primaryColor: .blue, backgroundColor: .blue),
        Theme(name: "Diet Coke", emoji: "🥤", primaryColor: .gray, backgroundColor: .gray)
    ]
}

