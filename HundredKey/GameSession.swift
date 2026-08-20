//
//  GameSession.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

//
//  GameSession.swift
//  Hundred_Key
//

import Foundation

final class GameSession {

    static let shared =
        GameSession()

    private init() {}

    // MARK: - 設定

    let maxQuestions = 10

    // MARK: - 問題

    private(set) var currentQuestion = 0

    private(set) var correctCount = 0

    private(set) var wrongCount = 0

    // MARK: - コンボ

    private(set) var combo = 0

    private(set) var maxCombo = 0

    // MARK: - ポイント

    private(set) var gamePoints = 0

    // MARK: - 時間

    private var startTime: Date?

    // MARK: - ボス

    var boss: Boss?

    var bossDamage = 0

    // MARK: - 爆弾

    var bombCount = 0

    // MARK: - 結果

    var resultSaved = false

    // MARK: - ゲーム開始

    func startGame() {

        currentQuestion = 0

        correctCount = 0

        wrongCount = 0

        combo = 0

        maxCombo = 0

        gamePoints = 0

        startTime = Date()

        boss = nil

        bossDamage = 0

        bombCount = 0

        resultSaved = false

        BombGameManager.shared.reset()

        BossManager.shared.reset()

        DailyMissionManager.shared
            .resetIfNeeded()
    }

    // MARK: - 問題開始

    func startNextQuestion() -> Bool {

        if currentQuestion >= maxQuestions {

            return false
        }

        currentQuestion += 1

        return true
    }

    // MARK: - 正解

    func addCorrect() {

        correctCount += 1

        combo += 1

        if combo > maxCombo {

            maxCombo = combo
        }

        let basePoint = 10

        let comboBonus =
            min(combo * 2, 10)

        gamePoints +=
            basePoint + comboBonus

        DailyMissionManager.shared
            .addCorrect()

        if boss != nil {

            boss?.damage(1)

            bossDamage += 1
        }
    }

    // MARK: - 不正解

    func addWrong() {

        wrongCount += 1

        combo = 0
    }

    // MARK: - 爆弾

    func hitBomb() {

        bombCount += 1

        gamePoints -= 5

        if gamePoints < 0 {

            gamePoints = 0
        }

        combo = 0
    }

    // MARK: - ボス開始

    func startBoss() {

        boss =
            Boss(
                name: "キングボス",
                maxHP: 3,
                hp: 3
            )
    }

    // MARK: - 終了

    var isFinished: Bool {

        currentQuestion >= maxQuestions
    }

    // MARK: - 正解率

    var accuracy: Double {

        guard currentQuestion > 0 else {

            return 0
        }

        return
            Double(correctCount)
            /
            Double(currentQuestion)
            *
            100
    }

    // MARK: - 時間

    var elapsedTime: Double {

        guard
            let startTime
        else {
            return 0
        }

        return
            Date().timeIntervalSince(
                startTime
            )
    }

    // MARK: - 最終ポイント

    func savePoints() {

        PointManager.shared.add(
            gamePoints
        )
    }
}
