//
//  AmbientView.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 4/2/25.
//

import SwiftUI

struct AmbientView: View {
    var body: some View {
        
       ZStack {
            Color("CreamBackground").edgesIgnoringSafeArea(.all)
            
           Image(systemName: "music.note")
               .resizable()
               .frame(width: 50, height: 65)
               .foregroundColor(Color("CoffeeBrown"))
               
           
       
        }
    }
}

#Preview {
    AmbientView()
}
