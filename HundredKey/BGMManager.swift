//
//  BGMManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  BGMManager.swift
//  Hundred_Key
//

import Foundation
import AVFoundation

final class BGMManager {

    static let shared = BGMManager()

    private init() {}

    private var player: AVAudioPlayer?


    // ★ここをBGMのファイル名に変更
    private let bgmName = "HundredKeyBGM"


    func playBGM() {

        let isOn =
            UserDefaults.standard.object(
                forKey: "BGM_ON"
            ) as? Bool ?? true

        if !isOn {
            return
        }


        if let player = player,
           player.isPlaying {
            return
        }


        guard let url =
                Bundle.main.url(
                    forResource: bgmName,
                    withExtension: "mp3"
                )
        else {

            print(
                "\(bgmName).mp3 が見つかりません"
            )

            return
        }


        do {

            player =
                try AVAudioPlayer(
                    contentsOf: url
                )

            player?.numberOfLoops = -1

            player?.volume = 0.03

            player?.prepareToPlay()

            player?.play()

        } catch {

            print(
                "BGMエラー: \(error)"
            )
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

        playBGM()
    }
}
