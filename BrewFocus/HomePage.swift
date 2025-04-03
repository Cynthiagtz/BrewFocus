//
//  HomePage.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 4/2/25.
//

import SwiftUI

struct HomePage: View {
    @StateObject private var vm = HomePageViewModel()
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
                    .padding()
                    .foregroundColor(Color("Sangria"))
                
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
                
                // Slider for selecting minutes
                
                Slider(value: $vm.minutes, in: 1...10, step: 1)
                    .padding()
                    .frame(width: width)
                    .disabled(vm.isActive)
                    .animation(.easeInOut, value: vm.minutes)
                
                // Start and Reset buttons
                
                HStack(spacing: 50) {
                    Button("Start") {
                        vm.startPomodoro()
                    }
                    .disabled(vm.isActive)
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
            .alert("Timer done!", isPresented: $vm.showingAlert) {
                Button("Continue", role: .cancel) {
                    //add functionality here later
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
