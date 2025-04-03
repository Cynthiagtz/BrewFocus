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
        
        enum SessionType {
            case focus, shortBreak, longBreak
        }
        @Published var selectedSession: SessionType = .focus
        @Published var shouldCelebrate: Bool = false
        
        var selectedSessionName: String {
            switch selectedSession {
            case .focus:
                return "Focus"
            case .shortBreak:
                return "Short Break"
            case .longBreak:
                return "Long Break"
            }
        }
        
        func selectedSession(_ type: SessionType) {
            selectedSession = type
            switch type {
            case .focus:
                time = "25:00"
            case .shortBreak:
                time = "5:00"
            case .longBreak:
                time = "15:00"
            }
        }
        
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
        
        @Published var sessionsCompleted: Int = 0
        
        func startPomodoro() {
            switch selectedSession {
            case .focus:
                startTimer(minutes: 25)
            case .shortBreak:
                startTimer(minutes: 5)
            case .longBreak:
                startTimer(minutes: 15)
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
            
            if sessionsCompleted >= 4 {
                sessionsCompleted = 0
            }
        }
        
        @Published var progress: Double = 1.0
        
        func updateCountdown() {
            guard isActive else { return }
            
            let now = Date()
            let difference = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if difference <= 0 {
                self.isActive = false
                self.time = "00:00"
                
                if selectedSession == .focus {
                    self.sessionsCompleted += 1
                    if self.sessionsCompleted >= 4 {
                        self.shouldCelebrate = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.selectedSession = .longBreak
                            self.startPomodoro()
                        }
                    }
                }
                
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


