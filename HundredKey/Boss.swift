//
//  Boss 2.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/19.
//


import Foundation

struct Boss {

    let name: String
    let maxHP: Int

    var hp: Int

    var isDefeated: Bool {

        hp <= 0
    }

    mutating func damage(
        _ amount: Int
    ) {

        hp -= amount

        if hp < 0 {
            hp = 0
        }
    }
}