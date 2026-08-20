//
//  PointManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

import Foundation

final class PointManager {

    static let shared = PointManager()

    private init() {}

    private let key = "POINT"

    var points: Int {

        get {
            UserDefaults.standard.integer(
                forKey: key
            )
        }

        set {
            UserDefaults.standard.set(
                max(0, newValue),
                forKey: key
            )
        }
    }

    func add(_ amount: Int) {

        points += amount
    }

    func subtract(_ amount: Int) {

        points -= amount
    }

    func reset() {

        points = 0
    }
}
