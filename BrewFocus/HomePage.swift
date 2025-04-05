//
//  HomePage.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 4/2/25.
//

import SwiftUI

struct HomePage: View {
    @StateObject private var vm = HomePageViewModel()
    @State private var showCelebration = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    private let width: Double = 250
    var body: some View {
        ZStack {
            Color("CreamBackground").edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Welcome back, BrewMaster!")
                    .font(.headline)
                    .padding(.top)
                    .foregroundColor(Color("Sangria"))
    
                
                Text("Ready to brew some focus?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 15)
                    .foregroundColor(Color("Sangria"))
                    .padding(.bottom, 80)

                
                // Progress Ring with Timer in Center
                
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                        .frame(width: 200, height: 200)
                    
                    Circle()
                        .trim(from: 0.0, to: vm.progress)
                        .stroke(Color("CoffeeBrown"), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                        .rotationEffect(.degrees( -90))
                        .animation(.easeInOut, value: vm.progress)
                        .frame(width: 200, height: 200)
                    
                    Text(vm.time)
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(Color("Sangria"))
                }
                
                let sessionButtons: [(title: String, type: HomePageViewModel.SessionType)] = [("Focus", .focus), ("Short Break", .shortBreak), ("Long Break", .longBreak)]
                
                //session toggle buttons
                HStack(spacing: 15) {
                    ForEach(sessionButtons, id: \.title) { button in
                        Button(action: {
                            vm.selectedSession(button.type)
                        }) {
                            Text(button.title)
                                .padding()
                                .frame(minWidth: 90)
                                .background(vm.selectedSession == button.type ? Color("CoffeeBrown") : Color.gray.opacity(0.2))
                                .foregroundColor(vm.selectedSession == button.type ? Color("LatteBeige") : .black)
                                .cornerRadius(12)
                        }
                        //this lets the user change between modes even if the timer has been started
                        .disabled(false)
                    }
                }
                .padding(.top, 50)
                
                //coffee cupts to track sessions
//                Text("Brews: \(String(repeating: "☕️", count: vm.sessionsCompleted))")
//                    .font(.title3)
//                    .padding(.top, 10)
//                    .padding(.bottom, 20)
                
                
                HStack(spacing: 8) {
                    ForEach(0..<4) { index in
                        Text("☕️")
                            .font(.title)
                            .opacity(index < vm.sessionsCompleted ? 1.0 : 0.2)
                    }
                }
                .padding(.top, 20)
                .animation(.easeInOut, value: vm.sessionsCompleted)
                .padding(.bottom, 20)
                
                //celebratory message
                if showCelebration {
                    Text("You brewed 4 cups! Take a long break ☕✨")
                        .font(.headline)
                        .padding()
                        .background(Color("CaramelAccent").opacity(0.8))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .animation(.easeInOut, value: showCelebration)
                }
                    
                
                // Start/Pause and Reset buttons
                
                
                HStack(spacing: 50) {
                    
                    Button(vm.isActive ? (vm.isPaused ? "Resume" : "Pause") : "Start") {
                        if vm.isActive {
                            if vm.isPaused {
                                vm.resumeTimer()
                            } else {
                                vm.pauseTimer()
                            }
                        } else {
                            vm.startPomodoro()
                        }
                    }
                    .disabled(false)
                    .padding()
                    .background(Color("CoffeeBrown"))
                    .foregroundColor(Color("LatteBeige"))
                    .cornerRadius(15)
                    
                    Button("Reset", action: vm.resetTimer)
                        .padding()
                        .background(Color("CoffeeBrown"))
                        .foregroundColor(Color("LatteBeige"))
                        .cornerRadius(15)
                    
                }
                Spacer()
                
            }
            .padding()
            .alert(Text("Session Complete!"), isPresented: $vm.showingAlert) {
                Button("Continue", role: .cancel) {}
            } message: {
                Text("Great job! Your next session will begin now")
            }
            
//            .alert("Timer done!", isPresented: $vm.showingAlert) {
//                Button("Continue", role: .cancel) {
//                    //add functionality here later
//                }
//            }
            .onChange(of: vm.shouldCelebrate) {
                if vm.shouldCelebrate {
                    showCelebration = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        showCelebration = false
                        vm.shouldCelebrate = false
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            vm.updateCountdown()
        }
    }
}


                

      
            
//            Text("\(vm.time)")
//                .font(.system(size: 70, weight: .bold, design: .rounded))
//                .padding()
//                .frame(width: width)
//                .background(.thinMaterial)
//                .cornerRadius(20)
//                .overlay(RoundedRectangle(cornerRadius: 20)
//                    .stroke(Color.gray, lineWidth: 4))
//                .alert("Timer done!", isPresented: $vm.showingAlert) {
//                    Button("Continue", role: .cancel) {
//                        //add functionality here later
//                    }
//                }
            
            
        

#Preview {
    HomePage()
}
