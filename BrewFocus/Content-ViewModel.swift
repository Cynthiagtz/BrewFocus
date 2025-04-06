//
//  Content-ViewModel.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 4/2/25.
//
// This is where the timer functionality is nested
//

import SwiftUI
import Foundation

extension HomePage {
    final class HomePageViewModel: ObservableObject {
        
        //determining which session the user chose
        enum SessionType {
            case focus, shortBreak, longBreak
        }
        
        @Published var selectedSession: SessionType = .focus
        @Published var shouldCelebrate: Bool = false
        private var remainingTime: TimeInterval = 0
        @Published var isPaused: Bool = false
        
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
        
        //adjusting the timer based on the session type selected
        func selectedSession(_ type: SessionType) {
            selectedSession = type
            isPaused = false
            isActive = false // Don’t auto-start the timer
            resetTimer()
            
            switch type {
            case .focus:
                self.time = "25:00"
                self.minutes = 25
            case .shortBreak:
                self.time = "5:00"
                self.minutes = 5
            case .longBreak:
                self.time = "15:00"
                self.minutes = 15
            }
            
            self.progress = 1.0
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
        
        //function to start the timer based on the session type selected
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
            self.endDate = Date().addingTimeInterval(TimeInterval(initialTime * 60))
            self.remainingTime = TimeInterval(initialTime * 60)
            self.isActive = true
            self.isPaused = false
//            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: self.endDate)!
        }
        
        func pauseTimer() {
            let now = Date()
            self.remainingTime = endDate.timeIntervalSince(now)
            self.isPaused = true
        }
        
        func resumeTimer() {
            self.isPaused = false
            self.endDate = Date().addingTimeInterval(remainingTime)
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
            guard isActive && !isPaused else { return }
            
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
                    } else {
                        //short break after each focus session
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.selectedSession = .shortBreak
                            self.startPomodoro()
                        }
                    }
                } else {
                        //if we're on a break, go back to focus
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.selectedSession = .focus
                            self.startPomodoro()
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


