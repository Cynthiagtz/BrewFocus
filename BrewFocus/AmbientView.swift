//
//  AmbientView.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 4/2/25.
//

import SwiftUI

struct AmbientView: View {
    struct AmbientSound : Identifiable {
        let id = UUID()
        let name: String
        let emoji: String
        var fileName: String { name.lowercased().replacingOccurrences(of: " ", with: "")}
    }
    
    @State private var selectedSound: String? = nil
    @State private var volumes: [String: Float] = [:]
    
    let sounds: [AmbientSound] = [
        .init(name: "Rain", emoji: "🌧️"),
        .init(name: "Ocean", emoji: "🌊"),
        .init(name: "City", emoji: "🏙️"),
        .init(name: "Forest", emoji: "🌲"),
        .init(name: "Café", emoji: "☕️"),
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color("CreamBackground").ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(sounds) { sound in
                        VStack(spacing: 12) {
                            Button(action: {
                                if selectedSound == sound.name {
                                    SoundManager.shared.stopSound(named: sound.fileName)
                                    selectedSound = nil
                                } else {
                                    let vol = volumes[sound.name] ?? 0.8
                                    SoundManager.shared.playSound(named: sound.fileName, volume: vol)
                                    selectedSound = sound.name
                                }
                            }) {
                                VStack {
                                    Text(sound.emoji).font(.system(size: 40))
                                    Text(sound.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedSound == sound.name ? Color("CaramelAccent") : Color("LatteBeige").opacity(0.2))
                                .cornerRadius(15)
                            }
                            
                            if selectedSound == sound.name {
                                
                                let binding = Binding<Float>(
                                    get: {
                                        volumes[sound.name] ?? 0.8
                                    },
                                    set: { newVal in
                                        volumes[sound.name] = newVal
                                        SoundManager.shared.setVolume(for: sound.fileName, to: newVal)
                                    }
                                )
                                Slider(value: binding, in: 0...1)
                                    .accentColor(Color("CoffeeBrown"))
                                    .padding(.horizontal, 12)
                            }
                        }
                        .padding()
                    }
                    .padding()
                } //LZGrid close
               
                //sv close
                
                Spacer()
                
                //trying to link music apps
                HStack (alignment: .center, spacing: 50) {
                    
                    Button("Open Spotify") {
                        if let url = URL(string: "spotify://") {
                            UIApplication.shared.open(url)
                        }
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    
                    Button("Open Apple Music") {
                        if let url = URL(string: "music://") {
                            UIApplication.shared.open(url)
                        }
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    
                }
                
                .padding(.top, 90)
                
            }
        }//view close
    } //ambient view close
}

#Preview {
    AmbientView()
}
