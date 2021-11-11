//
//  SettingsModel.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import AVFoundation
import Foundation

class SoundsImplementation {
    var audioPlayerMusic: AVAudioPlayer?
    var audioSoundsSfx: AVAudioPlayer?

    static let shared = SoundsImplementation()

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

    func playMusic(sound: String, type: String, volume: Float) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayerMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayerMusic?.play()
                audioPlayerMusic?.volume = volume
            } catch {
                print("ERROR")
            }
        }
    }
}
