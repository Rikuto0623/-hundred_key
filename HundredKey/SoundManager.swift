//
//  SoundManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/17.
//


import AVFoundation

final class SoundManager {

    static let shared = SoundManager()

    private init() {}

    private var players: [AVAudioPlayer] = []

    func playSound(
        name: String,
        ext: String = "wav"
    ) {

        guard
            UserDefaults.standard.object(
                forKey: "SOUND_ON"
            ) == nil ||
            UserDefaults.standard.bool(
                forKey: "SOUND_ON"
            )
        else {
            return
        }

        guard
            let url = Bundle.main.url(
                forResource: name,
                withExtension: ext
            )
        else {
            return
        }

        do {

            let player =
                try AVAudioPlayer(
                    contentsOf: url
                )

            player.play()

            players.append(player)

        } catch {

            print("Sound error: \(error)")
        }
    }
}