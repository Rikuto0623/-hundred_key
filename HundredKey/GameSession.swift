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

    static let shared = GameSession()

    private init() {}


    let totalQuestions = 10


    var currentQuestion = 0

    var correctCount = 0

    var wrongCount = 0

    var resultSaved = false


    func startGame() {

        currentQuestion = 0

        correctCount = 0

        wrongCount = 0

        resultSaved = false
    }


    func addCorrect() {

        correctCount += 1

        currentQuestion += 1
    }


    func addWrong() {

        wrongCount += 1

        currentQuestion += 1
    }


    var isFinished: Bool {

        return currentQuestion >= totalQuestions
    }
}
