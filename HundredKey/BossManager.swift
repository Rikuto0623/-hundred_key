//
//  BossManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/19.
//


import Foundation

final class BossManager {

    static let shared =
        BossManager()

    private init() {}

    var boss: Boss?

    func startBoss() {

        boss =
            Boss(
                name: "キングボス",
                maxHP: 3,
                hp: 3
            )
    }

    func reset() {

        boss = nil
    }

    func attack() {

        boss?.damage(1)
    }

    var isDefeated: Bool {

        boss?.isDefeated ?? false
    }
}