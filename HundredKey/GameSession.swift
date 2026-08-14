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

class GameSession {

    static let shared = GameSession()

    // MARK: - ゲーム設定

    let totalQuestions: Int = 10

    // MARK: - ゲーム状態

    var currentQuestion: Int = 0
    var correctCount: Int = 0
    var wrongCount: Int = 0

    // MARK: - 結果保存

    var resultSaved: Bool = false

    // MARK: - ゲーム終了判定

    var isFinished: Bool {
        return currentQuestion >= totalQuestions
    }

    private init() {
    }

    // MARK: - ゲーム開始

    func startGame() {
        currentQuestion = 0
        correctCount = 0
        wrongCount = 0
        resultSaved = false
    }

    // MARK: - 正解

    func addCorrect() {

        guard !isFinished else {
            return
        }

        correctCount += 1
        currentQuestion += 1
    }

    // MARK: - 不正解

    func addWrong() {

        guard !isFinished else {
            return
        }

        wrongCount += 1
        currentQuestion += 1
    }

    // MARK: - 結果保存

    func saveResult() {
        resultSaved = true
    }

    // MARK: - リセット

    func reset() {
        currentQuestion = 0
        correctCount = 0
        wrongCount = 0
        resultSaved = false
    }
}
