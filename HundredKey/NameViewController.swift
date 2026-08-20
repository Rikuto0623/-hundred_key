//
//  NameViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  NameViewController.swift
//  Hundred_Key
//

import UIKit

final class NameViewController:
    UIViewController {

    private let petImageView =
        UIImageView()

    private let nameTextField =
        UITextField()

    private let startButton =
        UIButton(type: .system)

    override func viewDidLoad() {

        super.viewDidLoad()

        navigationItem.hidesBackButton =
            true

        setupUI()
    }

    private func setupUI() {

        view.backgroundColor =
            UIColor.systemBlue
                .withAlphaComponent(0.12)

        petImageView.image =
            UIImage(
                named: "pet_hiyokey"
            )

        petImageView.contentMode =
            .scaleAspectFit

        nameTextField.placeholder =
            "名前を入力してね"

        nameTextField.borderStyle =
            .roundedRect

        nameTextField.textAlignment =
            .center

        nameTextField.font =
            .systemFont(ofSize: 20)

        startButton.setTitle(
            "はじめる",
            for: .normal
        )

        startButton.setTitleColor(
            .white,
            for: .normal
        )

        startButton.backgroundColor =
            .systemGreen

        startButton.layer.cornerRadius =
            12

        startButton.titleLabel?.font =
            .boldSystemFont(
                ofSize: 21
            )

        startButton.addTarget(
            self,
            action: #selector(startGame),
            for: .touchUpInside
        )

        let stack =
            UIStackView(
                arrangedSubviews: [
                    petImageView,
                    nameTextField,
                    startButton
                ]
            )

        stack.axis = .vertical
        stack.spacing = 25

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
                constant: 40
            ),

            stack.trailingAnchor.constraint(
                equalTo:
                    view.trailingAnchor,
                constant: -40
            ),

            petImageView.heightAnchor.constraint(
                equalToConstant: 180
            ),

            nameTextField.heightAnchor.constraint(
                equalToConstant: 55
            ),

            startButton.heightAnchor.constraint(
                equalToConstant: 55
            )
        ])
    }

    @objc private func startGame() {

        let name =
            nameTextField.text?
                .trimmingCharacters(
                    in: .whitespacesAndNewlines
                ) ?? ""

        UserDefaults.standard.set(
            name.isEmpty
            ? "ゲスト"
            : name,
            forKey: "USER_NAME"
        )

        let home =
            HomeViewController()

        navigationController?.setViewControllers(
            [home],
            animated: true
        )
    }
}
