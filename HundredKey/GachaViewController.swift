//
//  GachaViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

import UIKit

final class GachaViewController:
    UIViewController {

    private let titleLabel =
        UILabel()

    private let pointLabel =
        UILabel()

    private let capsuleImageView =
        UIImageView()

    private let resultLabel =
        UILabel()

    private let oneButton =
        UIButton(type: .system)

    private let tenButton =
        UIButton(type: .system)

    private let historyButton =
        UIButton(type: .system)

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "ガチャ"

        setupUI()

        updatePoints()
    }

    private func setupUI() {

        view.backgroundColor =
            UIColor.systemPink
                .withAlphaComponent(0.08)

        titleLabel.text =
            "🎰 ガチャ"

        titleLabel.textAlignment =
            .center

        titleLabel.font =
            .boldSystemFont(
                ofSize: 31
            )

        pointLabel.textAlignment =
            .center

        pointLabel.font =
            .boldSystemFont(
                ofSize: 19
            )

        capsuleImageView.image =
            UIImage(
                named:
                    "gacha_machine"
            )

        capsuleImageView.contentMode =
            .scaleAspectFit

        resultLabel.textAlignment =
            .center

        resultLabel.numberOfLines =
            0

        makeButton(
            oneButton,
            title:
                "1回ガチャ　10pt"
        )

        makeButton(
            tenButton,
            title:
                "10連ガチャ　100pt"
        )

        makeButton(
            historyButton,
            title:
                "ガチャ履歴"
        )

        oneButton.addTarget(
            self,
            action: #selector(oneGacha),
            for: .touchUpInside
        )

        tenButton.addTarget(
            self,
            action: #selector(tenGacha),
            for: .touchUpInside
        )

        historyButton.addTarget(
            self,
            action: #selector(history),
            for: .touchUpInside
        )

        let stack =
            UIStackView(
                arrangedSubviews: [
                    titleLabel,
                    pointLabel,
                    capsuleImageView,
                    resultLabel,
                    oneButton,
                    tenButton,
                    historyButton
                ]
            )

        stack.axis = .vertical
        stack.spacing = 10

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

            capsuleImageView.heightAnchor.constraint(
                equalToConstant: 180
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
            .systemRed

        button.layer.cornerRadius =
            12

        button.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true
    }

    private func updatePoints() {

        pointLabel.text =
            "🪙 \(PointManager.shared.points) pt"
    }

    @objc private func oneGacha() {

        guard
            PointManager.shared.points >= 10
        else {

            resultLabel.text =
                "ポイントが足りないよ"

            return
        }

        PointManager.shared.subtract(
            10
        )

        let pet =
            GachaManager.shared.draw()

        resultLabel.text =
            "\(pet.name)\n\(pet.rarityText)\nGET！"

        updatePoints()
    }

    @objc private func tenGacha() {

        guard
            PointManager.shared.points >= 100
        else {

            resultLabel.text =
                "100pt必要だよ"

            return
        }

        PointManager.shared.subtract(
            100
        )

        let pets =
            GachaManager.shared.tenDraw()

        var text =
            "🎉 10連結果 🎉\n\n"

        for pet in pets {

            text +=
                "\(pet.name) \(pet.rarityText)\n"
        }

        resultLabel.text =
            text

        updatePoints()
    }

    @objc private func history() {

        navigationController?.pushViewController(
            GachaHistoryViewController(),
            animated: true
        )
    }
}
