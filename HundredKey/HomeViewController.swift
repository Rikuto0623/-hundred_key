//
//  HomeViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  HomeViewController.swift
//  Hundred_Key
//

import UIKit

final class HomeViewController:
    UIViewController {

    private let pointLabel =
        UILabel()

    private let petImageView =
        UIImageView()

    private let startButton =
        UIButton(type: .system)

    private let gachaButton =
        UIButton(type: .system)

    private let bookButton =
        UIButton(type: .system)

    private let rankingButton =
        UIButton(type: .system)

    private let settingsButton =
        UIButton(type: .system)

    private let missionButton =
        UIButton(type: .system)

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "HUNDRED KEY"

        setupUI()

        updateUI()

        BGMManager.shared.playBGM(
            name: "HundredKey_BGM"
        )
    }

    override func viewWillAppear(
        _ animated: Bool
    ) {

        super.viewWillAppear(animated)

        updateUI()
    }

    private func setupUI() {

        view.backgroundColor =
            UIColor.systemBlue
                .withAlphaComponent(0.08)

        pointLabel.textAlignment =
            .center

        pointLabel.font =
            .boldSystemFont(
                ofSize: 20
            )

        petImageView.contentMode =
            .scaleAspectFit

        makeButton(
            startButton,
            title: "ゲームスタート"
        )

        makeButton(
            gachaButton,
            title: "ガチャ"
        )

        makeButton(
            bookButton,
            title: "ペット図鑑"
        )

        makeButton(
            rankingButton,
            title: "ランキング"
        )

        makeButton(
            settingsButton,
            title: "設定"
        )

        makeButton(
            missionButton,
            title: "今日のミッション"
        )

        startButton.addTarget(
            self,
            action: #selector(startGame),
            for: .touchUpInside
        )

        gachaButton.addTarget(
            self,
            action: #selector(gacha),
            for: .touchUpInside
        )

        bookButton.addTarget(
            self,
            action: #selector(book),
            for: .touchUpInside
        )

        rankingButton.addTarget(
            self,
            action: #selector(ranking),
            for: .touchUpInside
        )

        settingsButton.addTarget(
            self,
            action: #selector(settings),
            for: .touchUpInside
        )

        missionButton.addTarget(
            self,
            action: #selector(mission),
            for: .touchUpInside
        )

        let stack =
            UIStackView(
                arrangedSubviews: [
                    pointLabel,
                    petImageView,
                    startButton,
                    gachaButton,
                    bookButton,
                    rankingButton,
                    settingsButton,
                    missionButton
                ]
            )

        stack.axis = .vertical
        stack.spacing = 9

        view.addSubview(stack)

        stack.translatesAutoresizingMaskIntoConstraints =
            false

        NSLayoutConstraint.activate([

            stack.centerYAnchor.constraint(
                equalTo:
                    view.centerYAnchor
            ),

            stack.leadingAnchor.constraint(
                equalTo:
                    view.leadingAnchor,
                constant: 35
            ),

            stack.trailingAnchor.constraint(
                equalTo:
                    view.trailingAnchor,
                constant: -35
            ),

            petImageView.heightAnchor.constraint(
                equalToConstant: 110
            )
        ])
    }

    private func makeButton(
        _ button: UIButton,
        title: String
    ) {

        button.setTitle(
            title,
            for: .normal
        )

        button.setTitleColor(
            .white,
            for: .normal
        )

        button.backgroundColor =
            .systemGreen

        button.layer.cornerRadius =
            12

        button.titleLabel?.font =
            .boldSystemFont(
                ofSize: 18
            )

        button.heightAnchor.constraint(
            equalToConstant: 48
        ).isActive = true
    }

    private func updateUI() {

        pointLabel.text =
            "🪙 \(PointManager.shared.points) pt"

        let petName =
            PetManager.shared.selectedPetName

        petImageView.image =
            PetManager.shared
                .pet(named: petName)
                .flatMap {
                    UIImage(
                        named: $0.imageName
                    )
                }
    }

    @objc private func startGame() {

        GameSession.shared.startGame()

        BGMManager.shared.stopBGM()

        navigationController?.pushViewController(
            QuizViewController(),
            animated: true
        )
    }

    @objc private func gacha() {

        navigationController?.pushViewController(
            GachaViewController(),
            animated: true
        )
    }

    @objc private func book() {

        navigationController?.pushViewController(
            PetBookViewController(),
            animated: true
        )
    }

    @objc private func ranking() {

        navigationController?.pushViewController(
            RankingViewController(),
            animated: true
        )
    }

    @objc private func settings() {

        navigationController?.pushViewController(
            SettingsViewController(),
            animated: true
        )
    }
    
    @objc private func Mission() {

        navigationController?.pushViewController(
            SettingsViewController(),
            animated: true
        )
    }

    @objc private func mission() {

        let alert =
            UIAlertController(
                title: "今日のミッション",
                message:
                    "正解 \(DailyMissionManager.shared.correctCount) / 10 問\n\n10問正解で50pt！",
                preferredStyle: .alert
            )

        if DailyMissionManager.shared
            .correctCount >= 10 &&
            !DailyMissionManager.shared
                .isRewardReceived {

            alert.addAction(
                UIAlertAction(
                    title: "報酬を受け取る",
                    style: .default
                ) { _ in

                    _ =
                        DailyMissionManager.shared
                            .receiveReward()

                    self.updateUI()
                }
            )
        }

        alert.addAction(
            UIAlertAction(
                title: "閉じる",
                style: .cancel
            )
        )

        present(
            alert,
            animated: true
        )
    }
}
