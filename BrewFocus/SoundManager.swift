//
//  SoundManager.swift
//  BrewFocus
//
//  Created by Cynthia McGowan on 4/5/25.
//

import Foundation
import AVFoundation

class SoundManager: ObservableObject {
    static let shared = SoundManager()
    private var players: [String: AVAudioPlayer] = [:]
    
    var audioPlayer: AVAudioPlayer?
    
    func playSound(named name: String, volume: Float = 1.0) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Sound file \(name) not found")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = volume
            player.numberOfLoops = -1 //loop forever
            player.play()
            players[name] = player
        } catch {
            print("Error playing \(name): \(error.localizedDescription)")
        }
    }
    
    func stopSound(named name: String) {
        players[name]?.stop()
        players.removeValue(forKey: name)
    }
    
    func setVolume(for name: String, to volume: Float) {
        players[name]?.volume = volume
    }
    
    func isPlaying(_ name: String) -> Bool {
        return players[name]?.isPlaying ?? false
    }
        
    
}
