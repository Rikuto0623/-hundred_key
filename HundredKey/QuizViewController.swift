//
//  QuizViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

import UIKit

class QuizViewController: UIViewController, UITextFieldDelegate {

    // MARK: - UI

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    // MARK: - 問題

    private var currentNumber = 0
    private var correctAnswer = 0

    // MARK: - ゲーム

    private let totalQuestions = 10
    private var isAnswering = false
    private var gameEnded = false

    // MARK: - タイマー

    private var timer: Timer?
    private var startTime: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        GameSession.shared.startGame()

        startTime = Date()
        startTimer()

        showNextQuestion()
    }

    private func setupUI() {

        answerTextField.keyboardType = .numberPad
        answerTextField.delegate = self
        answerTextField.textAlignment = .center

        timerLabel.text = "0.0秒"
        questionNumberLabel.text = "1 / 10"

        progressView.progress = 0

        answerButton.setTitle("回答", for: .normal)
    }

    // MARK: - 次の問題

    func showNextQuestion() {

        // 10問終了
        if GameSession.shared.isFinished {
            goToResult()
            return
        }

        isAnswering = false

        answerTextField.text = ""
        answerTextField.isEnabled = true
        answerButton.isEnabled = true

        currentNumber = Int.random(in: 1...100)

        correctAnswer = 100 - currentNumber

        questionLabel.text =
            "\(currentNumber) に何を足したら 100 になる？"

        let question =
            GameSession.shared.currentQuestion + 1

        questionNumberLabel.text =
            "\(question) / \(totalQuestions)"

        progressView.progress =
            Float(GameSession.shared.currentQuestion)
            / Float(totalQuestions)
    }

    // MARK: - 回答

    @IBAction func answerButtonTapped(_ sender: UIButton) {

        submitAnswer()
    }

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        submitAnswer()

        return true
    }

    private func submitAnswer() {

        guard !isAnswering else {
            return
        }

        guard !gameEnded else {
            return
        }

        guard let text = answerTextField.text,
              let answer = Int(text) else {
            return
        }

        isAnswering = true

        answerTextField.resignFirstResponder()
        answerTextField.isEnabled = false
        answerButton.isEnabled = false

        // 正解
        if answer == correctAnswer {

            GameSession.shared.addCorrect()

            performSegue(
                withIdentifier: "CorrectSegue",
                sender: nil
            )

        }

        // 不正解
        else {

            GameSession.shared.addWrong()

            performSegue(
                withIdentifier: "WrongSegue",
                sender: nil
            )
        }
    }

    // MARK: - Result

    func goToResult() {

        guard !gameEnded else {
            return
        }

        gameEnded = true

        stopTimer()

        progressView.progress = 1.0

        performSegue(
            withIdentifier: "ResultSegue",
            sender: nil
        )
    }

    // MARK: - Segue

    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {

        if let correctVC =
            segue.destination as? CorrectViewController {

            correctVC.correctAnswer =
                correctAnswer

            correctVC.quizViewController = self
        }

        if let wrongVC =
            segue.destination as? WrongViewController {

            wrongVC.correctAnswer =
                correctAnswer

            wrongVC.quizViewController = self
        }

        if let resultVC =
            segue.destination as? ResultViewController {

            resultVC.correctCount =
                GameSession.shared.correctCount

            if let startTime = startTime {

                resultVC.time =
                    Date().timeIntervalSince(startTime)

            } else {

                resultVC.time = 0
            }
        }
    }

    // MARK: - タイマー

    private func startTimer() {

        timer?.invalidate()

        timer = Timer.scheduledTimer(
            withTimeInterval: 0.1,
            repeats: true
        ) { [weak self] _ in

            guard let self = self,
                  let startTime = self.startTime else {
                return
            }

            let elapsed =
                Date().timeIntervalSince(startTime)

            self.timerLabel.text =
                String(format: "%.1f秒", elapsed)
        }
    }

    private func stopTimer() {

        timer?.invalidate()
        timer = nil
    }

    deinit {

        timer?.invalidate()
    }
}
