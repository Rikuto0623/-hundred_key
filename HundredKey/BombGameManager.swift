//
//  BombGameManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/19.
//


import Foundation

final class BombGameManager {

    static let shared =
        BombGameManager()

    private init() {}

    var bombCount = 0

    let bomb =
        Bomb(
            damage: 1,
            penaltyPoint: 5
        )

    func reset() {

        bombCount = 0
    }

    func explode() {

        bombCount += 1

        PointManager.shared.subtract(
            bomb.penaltyPoint
        )
    }
}