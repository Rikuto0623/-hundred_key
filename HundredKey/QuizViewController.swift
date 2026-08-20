//
//  QuizViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

//
//  QuizViewController.swift
//  hundredKey
//

import UIKit

class QuizViewController: UIViewController, UITextFieldDelegate {

    // MARK: - UI

    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var comboLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!

    // MARK: - クイズ

    private var currentNumber: Int = 0
    private var correctAnswer: Int = 0

    // これが今回の correctCount エラーを直す部分
    private var correctCount: Int = 0

    private var questionCount: Int = 0
    private let totalQuestions: Int = 10

    // MARK: - コンボ

    private var combo: Int = 0

    // MARK: - ポイント

    private var earnedPoint: Int = 0

    // MARK: - タイマー

    private var timer: Timer?
    private var elapsedTime: Double = 0

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        startQuiz()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        timer?.invalidate()
    }

    // MARK: - UI設定

    private func setupUI() {

        answerTextField.delegate = self

        answerTextField.keyboardType = .numberPad
        answerTextField.placeholder = "答えを入力"

        answerButton.setTitle("答える", for: .normal)

        progressView.progress = 0

        comboLabel.text = "🔥 コンボ 0"

        pointLabel.text = "⭐ 0 pt"

        timerLabel.text = "⏱ 0 秒"

        answerTextField.layer.cornerRadius = 10
        answerButton.layer.cornerRadius = 10
    }

    // MARK: - クイズ開始

    private func startQuiz() {

        questionCount = 0
        correctCount = 0
        combo = 0
        earnedPoint = 0
        elapsedTime = 0

        startTimer()

        nextQuestion()
    }

    // MARK: - 次の問題

    private func nextQuestion() {

        // 10問終わったら結果画面
        if questionCount >= totalQuestions {

            finishQuiz()
            return
        }

        questionCount += 1

        // 1〜100
        currentNumber = Int.random(in: 1...100)

        // 100にするために足す数
        correctAnswer = 100 - currentNumber

        questionNumberLabel.text =
            "\(questionCount) / \(totalQuestions)"

        questionLabel.text =
            "\(currentNumber) に\n何を足したら\n100になる？"

        answerTextField.text = ""

        updateProgress()

        answerTextField.becomeFirstResponder()
    }

    // MARK: - プログレス

    private func updateProgress() {

        let progress =
            Float(questionCount) / Float(totalQuestions)

        progressView.setProgress(
            progress,
            animated: true
        )
    }

    // MARK: - 答える

    @IBAction func answerButtonTapped(_ sender: UIButton) {

        checkAnswer()
    }

    // MARK: - Enterでも回答

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        checkAnswer()

        return true
    }

    // MARK: - 正解判定

    private func checkAnswer() {

        guard let text = answerTextField.text,
              let answer = Int(text) else {

            showInputAlert()

            return
        }

        answerTextField.resignFirstResponder()

        if answer == correctAnswer {

            // 正解数
            correctCount += 1

            // コンボ
            combo += 1

            // ポイント
            let point = 10 + (combo - 1) * 2

            earnedPoint += point

            // ミッション
            MissionManager.shared.addCorrectAnswer()

            // 正解画面
            showCorrectView()

        } else {

            // 不正解
            combo = 0

            // 不正解画面
            showWrongView()
        }

        updateCombo()
        updatePoint()
    }

    // MARK: - コンボ表示

    private func updateCombo() {

        comboLabel.text =
            "🔥 コンボ \(combo)"
    }

    // MARK: - ポイント表示

    private func updatePoint() {

        pointLabel.text =
            "⭐ \(earnedPoint) pt"
    }

    // MARK: - 入力エラー

    private func showInputAlert() {

        let alert = UIAlertController(
            title: "答えを入力してね",
            message: "数字を入力してください。",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        present(
            alert,
            animated: true
        )
    }

    // MARK: - 正解画面

    private func showCorrectView() {

        performSegue(
            withIdentifier: "CorrectSegue",
            sender: nil
        )
    }

    // MARK: - 不正解画面

    private func showWrongView() {

        performSegue(
            withIdentifier: "WrongSegue",
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

            correctVC.correctAnswer = correctAnswer
            correctVC.point = 10 + (combo - 1) * 2

            correctVC.isLastQuestion =
                questionCount >= totalQuestions

            correctVC.onNext = { [weak self] in

                self?.handleNextQuestion()
            }
        }

        if let wrongVC =
            segue.destination as? WrongViewController {

            wrongVC.correctAnswer = correctAnswer

            wrongVC.isLastQuestion =
                questionCount >= totalQuestions

            wrongVC.onNext = { [weak self] in

                self?.handleNextQuestion()
            }
        }

        if let resultVC =
            segue.destination as? ResultViewController {

            resultVC.correctCount = correctCount
            resultVC.time = elapsedTime
            resultVC.earnedPoint = earnedPoint
        }
    }

    // MARK: - 次の問題へ

    private func handleNextQuestion() {

        if questionCount >= totalQuestions {

            finishQuiz()

        } else {

            nextQuestion()
        }
    }

    // MARK: - 結果画面

    private func finishQuiz() {

        timer?.invalidate()

        performSegue(
            withIdentifier: "ResultSegue",
            sender: nil
        )
    }

    // MARK: - タイマー

    private func startTimer() {

        timer?.invalidate()

        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in

            guard let self = self else {
                return
            }

            self.elapsedTime += 1

            self.timerLabel.text =
                "⏱ \(Int(self.elapsedTime)) 秒"
        }
    }
}
