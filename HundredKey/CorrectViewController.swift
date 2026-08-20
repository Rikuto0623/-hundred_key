//
//  CorrectViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

//
//  CorrectViewController.swift
//  hundredKey
//

import UIKit

class CorrectViewController: UIViewController {

    // MARK: - Quizから受け取る

    var correctAnswer: Int = 0
    var point: Int = 10

    var isLastQuestion: Bool = false

    var onNext: (() -> Void)?

    // MARK: - UI

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var petImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {

        titleLabel.text = "正解！すごい！"

        answerLabel.text =
            "答えは \(correctAnswer) だよ！"

        pointLabel.text =
            "+ \(point) pt"

        if isLastQuestion {

            nextButton.setTitle(
                "結果を見る",
                for: .normal
            )

        } else {

            nextButton.setTitle(
                "次へ",
                for: .normal
            )
        }

        nextButton.layer.cornerRadius = 10
    }

    @IBAction func nextButtonTapped(
        _ sender: UIButton
    ) {

        dismiss(
            animated: true
        ) { [weak self] in

            self?.onNext?()
        }
    }
}
