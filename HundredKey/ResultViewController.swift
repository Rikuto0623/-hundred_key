//
//  ResultViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

//
//  ResultViewController.swift
//  Hundred_Key
//

import UIKit

class ResultViewController: UIViewController {

    // MARK: - UI

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!

    // MARK: - Quizから受け取るデータ

    var correctCount: Int = 0
    var time: Double = 0.0

    // MARK: - ポイント

    private var earnedPoint: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        showResult()
        showPet()
    }

    // MARK: - 結果表示

    private func showResult() {

        let totalQuestions = 10

        // 正答率
        let accuracy =
            Double(correctCount)
            / Double(totalQuestions)
            * 100

        // スコア
        scoreLabel.text =
            "\(correctCount) / \(totalQuestions)問正解"

        // タイム
        timeLabel.text =
            String(
                format: "タイム %.1f秒",
                time
            )

        // 正答率
        accuracyLabel.text =
            String(
                format: "正答率 %.0f%%",
                accuracy
            )

        // ランク
        let rank =
            calculateRank(
                accuracy: accuracy
            )

        rankLabel.text =
            "ランク \(rank)"

        // ポイント
        earnedPoint =
            calculatePoint(
                correctCount: correctCount
            )

        pointLabel.text =
            "+\(earnedPoint)ポイント"

        // ポイントを保存
        savePoint()
    }

    // MARK: - ランク計算

    private func calculateRank(
        accuracy: Double
    ) -> String {

        if accuracy >= 90 {
            return "S"

        } else if accuracy >= 70 {
            return "A"

        } else if accuracy >= 50 {
            return "B"

        } else {
            return "C"
        }
    }

    // MARK: - ポイント計算

    private func calculatePoint(
        correctCount: Int
    ) -> Int {

        // 1問正解 = 10ポイント
        return correctCount * 10
    }

    // MARK: - ポイント保存

    private func savePoint() {

        let oldPoint =
            UserDefaults.standard.integer(
                forKey: "POINT"
            )

        let newPoint =
            oldPoint + earnedPoint

        UserDefaults.standard.set(
            newPoint,
            forKey: "POINT"
        )
    }

    // MARK: - ペット表示

    private func showPet() {

        petImageView.contentMode = .scaleAspectFit

        guard let pet = PetManager.shared.selectedPet else {

            petImageView.image = nil
            petNameLabel.text = "ペットなし"

            return
        }

        petImageView.image =
            UIImage(named: pet.imageName)

        petNameLabel.text =
            pet.name
    }

    // MARK: - ホームへ

    @IBAction func homeButtonTapped(
        _ sender: UIButton
    ) {

        GameSession.shared.reset()

        navigationController?
            .popToRootViewController(
                animated: true
            )
    }
}
