//
//  MissionViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/19.
//


//
//  MissionViewController.swift
//  hundredKey
//

import UIKit

class MissionViewController: UIViewController {

    // MARK: - UI

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var claimButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        updateMission()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateMission()
    }

    // MARK: - UI設定

    private func setupUI() {

        titleLabel.text = "今日のミッション"

        missionLabel.text = "正解を10問しよう！"

        rewardLabel.text = "報酬 50 pt"

        progressView.progress = 0

        claimButton.setTitle(
            "報酬を受け取る",
            for: .normal
        )

        closeButton.setTitle(
            "閉じる",
            for: .normal
        )

        claimButton.layer.cornerRadius = 10
        closeButton.layer.cornerRadius = 10
    }

    // MARK: - ミッション更新

    private func updateMission() {

        let manager = MissionManager.shared

        let current = manager.correctCount
        let target = manager.targetCount

        progressLabel.text = "\(current) / \(target) 問"

        let progress = Float(current) / Float(target)

        progressView.progress = min(progress, 1.0)

        if manager.isCompleted {

            if manager.isRewardClaimed {

                claimButton.setTitle(
                    "報酬受取済み！",
                    for: .normal
                )

                claimButton.isEnabled = false

            } else {

                claimButton.setTitle(
                    "報酬を受け取る！",
                    for: .normal
                )

                claimButton.isEnabled = true
            }

        } else {

            claimButton.setTitle(
                "10問正解すると受け取れます",
                for: .normal
            )

            claimButton.isEnabled = false
        }
    }

    // MARK: - 報酬ボタン

    @IBAction func claimButtonTapped(_ sender: UIButton) {

        let reward = MissionManager.shared.claimReward()

        if reward > 0 {

            let alert = UIAlertController(
                title: "ミッション達成！🎉",
                message: "+\(reward) pt 獲得！",
                preferredStyle: .alert
            )

            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default
                ) { [weak self] _ in

                    self?.updateMission()
                }
            )

            present(alert, animated: true)

        } else {

            updateMission()
        }
    }

    // MARK: - 閉じる

    @IBAction func closeButtonTapped(_ sender: UIButton) {

        dismiss(animated: true)
    }
}