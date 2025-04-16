//
//  ThemeManager.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 4/5/25.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    @Published var selectedTheme: Theme = Themes.all.first! //default to match
    
    func selectTheme(_ theme: Theme) {
        selectedTheme = theme
        // You can later persist with UserDefaults here

    }
    
}
