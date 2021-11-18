//
//  SoundService.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 18/11/21.
//

import AVFoundation
import Foundation

class SoundService {
    var audioSoundsSfx: AVAudioPlayer?

    static let shared = SoundService()

    func playSound(sound: String, type: String, volume: Float) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioSoundsSfx = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioSoundsSfx?.play()
                audioSoundsSfx?.volume = volume
            } catch {
                print("ERROR")
            }
        }
    }

    func playButtonEffects() {
        playSound(sound: "hey", type: "wav", volume: 1)
    }
}
