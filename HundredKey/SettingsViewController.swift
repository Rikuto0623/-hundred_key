//
//  SettingsViewController 2.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/19.
//


import UIKit

final class SettingsViewController:
    UIViewController {

    private let nameTextField =
        UITextField()

    private let ageTextField =
        UITextField()

    private let bgmSwitch =
        UISwitch()

    private let soundSwitch =
        UISwitch()

    private let saveButton =
        UIButton(type: .system)

    private let resetButton =
        UIButton(type: .system)

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "設定"

        setupUI()

        loadSettings()
    }

    private func setupUI() {

        view.backgroundColor =
            .systemBackground

        nameTextField.placeholder =
            "名前"

        nameTextField.borderStyle =
            .roundedRect

        ageTextField.placeholder =
            "年齢"

        ageTextField.borderStyle =
            .roundedRect

        ageTextField.keyboardType =
            .numberPad

        bgmSwitch.isOn =
            true

        soundSwitch.isOn =
            true

        let bgmRow =
            makeRow(
                title: "BGM",
                control: bgmSwitch
            )

        let soundRow =
            makeRow(
                title: "効果音",
                control: soundSwitch
            )

        saveButton.setTitle(
            "保存",
            for: .normal
        )

        saveButton.setTitleColor(
            .white,
            for: .normal
        )

        saveButton.backgroundColor =
            .systemGreen

        saveButton.layer.cornerRadius =
            12

        saveButton.addTarget(
            self,
            action: #selector(save),
            for: .touchUpInside
        )

        resetButton.setTitle(
            "データリセット",
            for: .normal
        )

        resetButton.setTitleColor(
            .white,
            for: .normal
        )

        resetButton.backgroundColor =
            .systemRed

        resetButton.layer.cornerRadius =
            12

        resetButton.addTarget(
            self,
            action: #selector(resetData),
            for: .touchUpInside
        )

        let stack =
            UIStackView(
                arrangedSubviews: [
                    nameTextField,
                    ageTextField,
                    bgmRow,
                    soundRow,
                    saveButton,
                    resetButton
                ]
            )

        stack.axis = .vertical

        stack.spacing = 15

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

            nameTextField.heightAnchor.constraint(
                equalToConstant: 50
            ),

            ageTextField.heightAnchor.constraint(
                equalToConstant: 50
            ),

            saveButton.heightAnchor.constraint(
                equalToConstant: 50
            ),

            resetButton.heightAnchor.constraint(
                equalToConstant: 50
            )
        ])
    }

    private func makeRow(
        title: String,
        control: UISwitch
    ) -> UIView {

        let label =
            UILabel()

        label.text =
            title

        label.font =
            .boldSystemFont(
                ofSize: 18
            )

        let row =
            UIStackView(
                arrangedSubviews: [
                    label,
                    control
                ]
            )

        row.axis =
            .horizontal

        row.distribution =
            .equalSpacing

        return row
    }

    private func loadSettings() {

        nameTextField.text =
            UserDefaults.standard.string(
                forKey: "USER_NAME"
            )

        ageTextField.text =
            UserDefaults.standard.string(
                forKey: "USER_AGE"
            )

        bgmSwitch.isOn =
            UserDefaults.standard.object(
                forKey: "BGM_ON"
            ) as? Bool ?? true

        soundSwitch.isOn =
            UserDefaults.standard.object(
                forKey: "SOUND_ON"
            ) as? Bool ?? true
    }

    @objc private func save() {

        UserDefaults.standard.set(
            nameTextField.text ?? "ゲスト",
            forKey: "USER_NAME"
        )

        UserDefaults.standard.set(
            ageTextField.text ?? "",
            forKey: "USER_AGE"
        )

        UserDefaults.standard.set(
            bgmSwitch.isOn,
            forKey: "BGM_ON"
        )

        UserDefaults.standard.set(
            soundSwitch.isOn,
            forKey: "SOUND_ON"
        )

        navigationController?.popViewController(
            animated: true
        )
    }

    @objc private func resetData() {

        let alert =
            UIAlertController(
                title: "データリセット",
                message:
                    "本当に全部のデータを消しますか？",
                preferredStyle: .alert
            )

        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: .cancel
            )
        )

        alert.addAction(
            UIAlertAction(
                title: "リセット",
                style: .destructive
            ) { _ in

                let defaults =
                    UserDefaults.standard

                let keys = [
                    "POINT",
                    "USER_NAME",
                    "USER_AGE",
                    "OWNED_PETS",
                    "SELECTED_PET",
                    "RANKING",
                    "GACHA_DRAW_COUNT",
                    "GACHA_HISTORY",
                    "MISSION_DATE",
                    "MISSION_CORRECT",
                    "MISSION_REWARD"
                ]

                for key in keys {

                    defaults.removeObject(
                        forKey: key
                    )
                }

                PetManager.shared
                    .ownedPetNames =
                    ["ヒヨキー"]

                PetManager.shared
                    .selectedPetName =
                    "ヒヨキー"

                self.loadSettings()
            }
        )

        present(
            alert,
            animated: true
        )
    }
}