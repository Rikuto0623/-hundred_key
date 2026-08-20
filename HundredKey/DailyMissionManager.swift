//
//  DailyMissionManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/19.
//


import Foundation

final class DailyMissionManager {

    static let shared =
        DailyMissionManager()

    private init() {}

    private let dateKey =
        "MISSION_DATE"

    private let correctKey =
        "MISSION_CORRECT"

    private let rewardKey =
        "MISSION_REWARD"

    private var today: String {

        let formatter =
            DateFormatter()

        formatter.dateFormat =
            "yyyy-MM-dd"

        return formatter.string(
            from: Date()
        )
    }

    func resetIfNeeded() {

        let savedDate =
            UserDefaults.standard.string(
                forKey: dateKey
            )

        if savedDate != today {

            UserDefaults.standard.set(
                today,
                forKey: dateKey
            )

            UserDefaults.standard.set(
                0,
                forKey: correctKey
            )

            UserDefaults.standard.set(
                false,
                forKey: rewardKey
            )
        }
    }

    var correctCount: Int {

        UserDefaults.standard.integer(
            forKey: correctKey
        )
    }

    var isRewardReceived: Bool {

        UserDefaults.standard.bool(
            forKey: rewardKey
        )
    }

    func addCorrect() {

        resetIfNeeded()

        let count =
            correctCount + 1

        UserDefaults.standard.set(
            count,
            forKey: correctKey
        )
    }

    func receiveReward() -> Bool {

        resetIfNeeded()

        guard
            correctCount >= 10,
            !isRewardReceived
        else {
            return false
        }

        UserDefaults.standard.set(
            true,
            forKey: rewardKey
        )

        PointManager.shared.add(50)

        return true
    }
}