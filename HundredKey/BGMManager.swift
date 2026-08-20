//
//  BGMManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

import AVFoundation

final class BGMManager {

    static let shared = BGMManager()

    private var player: AVAudioPlayer?

    private init() {}

    func playBGM(name: String) {

        guard
            UserDefaults.standard.object(
                forKey: "BGM_ON"
            ) == nil ||
            UserDefaults.standard.bool(
                forKey: "BGM_ON"
            )
        else {
            return
        }

        guard
            let url = Bundle.main.url(
                forResource: name,
                withExtension: "mp3"
            )
        else {
            return
        }

        do {

            player = try AVAudioPlayer(
                contentsOf: url
            )

            player?.numberOfLoops = -1

            player?.volume = 0.5

            player?.play()

        } catch {

            print("BGM error: \(error)")
        }
    }

    func stopBGM() {

        player?.stop()
        player = nil
    }

    func pauseBGM() {

        player?.pause()
    }

    func resumeBGM() {

        player?.play()
    }
}
