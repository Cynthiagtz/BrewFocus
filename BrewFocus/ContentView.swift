//
//  ContentView.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 3/22/25.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("CreamBackground").edgesIgnoringSafeArea(.all)
                VStack (spacing: 20) {
                    HStack(spacing: 0) {
                        Text("Brew")
                            .font(.custom("mainFont", size: 48) .weight(.bold))
                            .foregroundColor(Color("CoffeeBrown"))
                        
                        Text("Focus")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(Color("LatteBeige"))
                    }
                    
                    
                    Text("where focus meets comfort")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    
                    
                    NavigationLink(destination: MainTabView()) {
                        Text("let's get brewing")
                            .padding(.all)
                            .background(Color("CaramelAccent"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    
                    Spacer()
                    
                    Image(systemName: "cup.and.saucer.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("CoffeeBrown"))
                }
                
                .padding(.top, 100)
                .padding(.bottom, 50)
                
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
}

