//
//  MainTabView.swift
//  BrewFocus
//  Where the tab bar will be held
//  Created by Cynthia McGowan on 4/2/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Timer")
                }
            ThemesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Themes")
                }
            AmbientView()
                .tabItem {
                    Image(systemName: "sun.max")
                    Text("Ambiance")
                }
        }
        .accentColor(Color("CoffeeBrown"))
    }
}

#Preview {
    MainTabView()
}
