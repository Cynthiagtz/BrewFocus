//
//  Content-ViewModel.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 4/2/25.
//

import SwiftUI
import Foundation

extension HomePage {
    final class HomePageViewModel: ObservableObject {
        
        @Published var isActive: Bool = false
        @Published var showingAlert: Bool = false
        @Published var isBreak: Bool = false
        @Published var time: String = "25:00"
        @Published var minutes: Float = 5.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        private var initialTime = 0
        private var endDate = Date()
        @Published var breakTime: String = "5:00"
        @Published var session: Int = 1
        
        func startPomodoro() {
            if isBreak && session != 4 {
                startTimer(minutes: 5) //short break
            } else if isBreak && session == 4 {
                startTimer(minutes: 15)
            } else {
                startTimer(minutes: 25)
            }
        }
        
        func startTimer(minutes: Float) {
            self.initialTime = Int(minutes)
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: self.endDate)!
        }
        
        func resetTimer() {
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(minutes)):00"
        }
        
        @Published var progress: Double = 1.0
        
        func updateCountdown() {
            guard isActive else { return }
            
            let now = Date()
            let difference = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if difference <= 0 {
                self.isActive = false
                self.time = "00:00"
                self.session += 1
                self.isBreak.toggle()
                self.showingAlert = true
//                this is where notifications can be added
                return
            }
            
            let date = Date(timeIntervalSince1970: difference)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            self.minutes = Float(minutes)
            self.time = String(format: "%d:%02d", minutes, seconds)
            
            let totalSeconds = Double(initialTime) * 60
            let remaining = max(difference, 0)
            self.progress = remaining / totalSeconds
        }
        
            
    }
}


