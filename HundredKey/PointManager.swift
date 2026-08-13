//
//  PointManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  PointManager.swift
//  Hundred_Key
//

import Foundation

final class PointManager {

    static let shared = PointManager()

    private init() {}

    private let pointKey = "POINT"


    var point: Int {

        get {
            return UserDefaults.standard.integer(
                forKey: pointKey
            )
        }

        set {
            UserDefaults.standard.set(
                newValue,
                forKey: pointKey
            )
        }
    }


    func add(
        _ value: Int
    ) {

        point += value
    }


    func subtract(
        _ value: Int
    ) {

        point =
            max(
                0,
                point - value
            )
    }


    func reset() {

        point = 0
    }
}