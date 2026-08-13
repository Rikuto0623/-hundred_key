//
//  QuizViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

//
//  QuizViewController.swift
//  Hundred_Key
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var questionNumberLabel: UILabel!

    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var answerTextField: UITextField!

    @IBOutlet weak var answerButton: UIButton!


    private var randomNumber = 0

    private var correctAnswer = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        startQuestion()

        BGMManager.shared.stopBGM()
    }


    private func setupUI() {

        answerTextField.placeholder =
            "答えを入力"

        answerTextField.keyboardType =
            .numberPad

        answerTextField.textAlignment =
            .center

        answerButton.setTitle(
            "答える",
            for: .normal
        )

        answerButton.layer.cornerRadius =
            12
    }


    private func startQuestion() {

        randomNumber =
            Int.random(in: 1...100)


        correctAnswer =
            100 - randomNumber


        questionLabel.text =
            "\(randomNumber) に\n何を足したら100になる？"


        let number =
            GameSession.shared.currentQuestion + 1


        questionNumberLabel.text =
            "第\(number)問 / 10問"


        answerTextField.text = ""

        answerTextField.becomeFirstResponder()
    }


    @IBAction func answerButtonTapped(
        _ sender: UIButton
    ) {

        guard let text =
                answerTextField.text
        else {
            return
        }


        let input =
            text.trimmingCharacters(
                in: .whitespacesAndNewlines
            )


        if input.isEmpty {

            showAlert(
                title: "答えを入力してね",
                message: "数字を入力してください。"
            )

            return
        }


        guard let answer =
                Int(input)
        else {

            showAlert(
                title: "数字を入力してね",
                message: "数字だけ入力してください。"
            )

            return
        }


        answerTextField.resignFirstResponder()


        if answer == correctAnswer {

            GameSession.shared.addCorrect()

            performSegue(
                withIdentifier: "toCorrect",
                sender: nil
            )

        } else {

            GameSession.shared.addWrong()

            performSegue(
                withIdentifier: "toWrong",
                sender: nil
            )
        }
    }


    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {

        if segue.identifier == "toWrong" {

            if let wrongVC =
                segue.destination
                    as? WrongViewController {

                wrongVC.correctAnswer =
                    correctAnswer
            }
        }
    }


    private func showAlert(
        title: String,
        message: String
    ) {

        let alert =
            UIAlertController(
                title: title,
                message: message,
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
}
