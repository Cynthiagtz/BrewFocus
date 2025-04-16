//
//  BrewFocusApp.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 3/22/25.
//

import SwiftUI

@main
struct BrewFocusApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
            }
        }
    }
   
