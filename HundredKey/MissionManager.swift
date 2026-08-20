//
//  MissionManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/19.
//


//
//  MissionManager.swift
//  hundredKey
//

import Foundation

final class MissionManager {

    static let shared = MissionManager()

    private init() {}

    // MARK: - UserDefaults Keys

    private let correctKey = "MISSION_CORRECT_COUNT"
    private let claimedKey = "MISSION_REWARD_CLAIMED"
    private let dateKey = "MISSION_DATE"

    // MARK: - ミッション設定

    let targetCount: Int = 10
    let rewardPoint: Int = 50

    // MARK: - 今日の日付

    private var todayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    // MARK: - 今日のミッション確認

    private func checkNewDay() {

        let savedDate = UserDefaults.standard.string(forKey: dateKey)

        if savedDate != todayString {

            UserDefaults.standard.set(0, forKey: correctKey)
            UserDefaults.standard.set(false, forKey: claimedKey)
            UserDefaults.standard.set(todayString, forKey: dateKey)

            UserDefaults.standard.synchronize()
        }
    }

    // MARK: - 正解数

    var correctCount: Int {

        checkNewDay()

        return UserDefaults.standard.integer(forKey: correctKey)
    }

    // MARK: - ミッション達成済み？

    var isCompleted: Bool {

        return correctCount >= targetCount
    }

    // MARK: - 報酬受け取り済み？

    var isRewardClaimed: Bool {

        checkNewDay()

        return UserDefaults.standard.bool(forKey: claimedKey)
    }

    // MARK: - 正解を追加

    func addCorrectAnswer() {

        checkNewDay()

        if isCompleted {
            return
        }

        let newCount = correctCount + 1

        UserDefaults.standard.set(
            min(newCount, targetCount),
            forKey: correctKey
        )

        UserDefaults.standard.synchronize()
    }

    // MARK: - 報酬を受け取る

    func claimReward() -> Int {

        checkNewDay()

        // まだ10問正解していない
        if !isCompleted {
            return 0
        }

        // すでに受け取っている
        if isRewardClaimed {
            return 0
        }

        UserDefaults.standard.set(true, forKey: claimedKey)

        // ポイントを追加
        let currentPoint = UserDefaults.standard.integer(forKey: "POINT")

        UserDefaults.standard.set(
            currentPoint + rewardPoint,
            forKey: "POINT"
        )

        UserDefaults.standard.synchronize()

        return rewardPoint
    }

    // MARK: - ミッションリセット

    func resetMission() {

        UserDefaults.standard.set(0, forKey: correctKey)
        UserDefaults.standard.set(false, forKey: claimedKey)
        UserDefaults.standard.set(todayString, forKey: dateKey)

        UserDefaults.standard.synchronize()
    }
}