//
//  ContentView.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 3/22/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("CreamBackground").edgesIgnoringSafeArea(.all)
        VStack (spacing: 20) {
            Text("Brew")
                /*.font(.system(size: 48, weight: .bold))*/ .foregroundColor(Color("CoffeeBrown"))
                .font(Font.custom("Modak", size: 48)) +
            Text("Focus")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(Color("LatteBeige"))
            
            Text("where focus meets comfort")
                .font(.headline)
                .foregroundStyle(.gray)
            
            Button(action: {
                //figure out later

            }) {
            
            Text("let's get brewing")
                .padding()
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

#Preview {
    ContentView()
}
