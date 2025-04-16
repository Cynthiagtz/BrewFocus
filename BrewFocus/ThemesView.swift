//
//  ThemesView.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 4/2/25.
//

import SwiftUI

struct ThemesView: View {
    @EnvironmentObject var themeManager: ThemeManager
   
    let themes = Themes.all
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                
                ForEach(themes) { theme in
                    let isSelected = themeManager.selectedTheme.name == theme.name
                    let background = isSelected ? theme.primaryColor.opacity(0.3) : theme.backgroundColor
                    
                    Button(action: {
                        themeManager.selectTheme(theme)
                        // TODO: Apply theme globally
                    }) {
                        VStack {
                            Text(theme.emoji).font(.system(size: 40))
                            Text(theme.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(background)
                        .cornerRadius(15)
                    }
                }
            }
            .padding()
        }
        .background(Color("CreamBackground").ignoresSafeArea())
        .navigationTitle("Themes")
    }
}

#Preview {
    ThemesView()
        .environmentObject(ThemeManager())
}
