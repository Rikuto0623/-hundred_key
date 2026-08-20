//
//  ResultViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

//
//  ResultViewController.swift
//  hundredKey
//

import UIKit

class ResultViewController: UIViewController {

    // MARK: - Quizから受け取る

    var correctCount: Int = 0
    var time: Double = 0
    var earnedPoint: Int = 0

    // MARK: - UI

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        showResult()
    }

    private func showResult() {

        titleLabel.text = "結果発表！"

        scoreLabel.text =
            "正解数      \(correctCount) / 10 問"

        let accuracy =
            Int(Double(correctCount) / 10.0 * 100.0)

        accuracyLabel.text =
            "正解率      \(accuracy) %"

        pointLabel.text =
            "獲得ポイント      +\(earnedPoint) pt"

        savePoint()
    }

    // MARK: - ポイント保存

    private func savePoint() {

        let currentPoint =
            UserDefaults.standard.integer(
                forKey: "POINT"
            )

        UserDefaults.standard.set(
            currentPoint + earnedPoint,
            forKey: "POINT"
        )
    }

    @IBAction func homeButtonTapped(
        _ sender: UIButton
    ) {

        navigationController?
            .popToRootViewController(
                animated: true
            )
    }
}
