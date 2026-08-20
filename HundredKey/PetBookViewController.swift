//
//  PetBookViewController 2.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/19.
//


import UIKit

final class PetBookViewController:
    UIViewController {

    private let textView =
        UITextView()

    private let selectButton =
        UIButton(type: .system)

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "ペット図鑑"

        setupUI()

        showBook()
    }

    override func viewWillAppear(
        _ animated: Bool
    ) {

        super.viewWillAppear(animated)

        showBook()
    }

    private func setupUI() {

        textView.isEditable =
            false

        textView.font =
            .systemFont(
                ofSize: 19
            )

        selectButton.setTitle(
            "ペットを選ぶ",
            for: .normal
        )

        selectButton.setTitleColor(
            .white,
            for: .normal
        )

        selectButton.backgroundColor =
            .systemGreen

        selectButton.layer.cornerRadius =
            12

        selectButton.addTarget(
            self,
            action: #selector(selectPet),
            for: .touchUpInside
        )

        view.addSubview(textView)

        view.addSubview(selectButton)

        textView.translatesAutoresizingMaskIntoConstraints =
            false

        selectButton.translatesAutoresizingMaskIntoConstraints =
            false

        NSLayoutConstraint.activate([

            textView.topAnchor.constraint(
                equalTo:
                    view.safeAreaLayoutGuide
                    .topAnchor,
                constant: 10
            ),

            textView.leadingAnchor.constraint(
                equalTo:
                    view.leadingAnchor,
                constant: 20
            ),

            textView.trailingAnchor.constraint(
                equalTo:
                    view.trailingAnchor,
                constant: -20
            ),

            textView.bottomAnchor.constraint(
                equalTo:
                    selectButton.topAnchor,
                constant: -10
            ),

            selectButton.leadingAnchor.constraint(
                equalTo:
                    view.leadingAnchor,
                constant: 40
            ),

            selectButton.trailingAnchor.constraint(
                equalTo:
                    view.trailingAnchor,
                constant: -40
            ),

            selectButton.bottomAnchor.constraint(
                equalTo:
                    view.safeAreaLayoutGuide
                    .bottomAnchor,
                constant: -10
            ),

            selectButton.heightAnchor.constraint(
                equalToConstant: 50
            )
        ])
    }

    private func showBook() {

        var text =
            "🐾 ペット図鑑\n\n"

        for pet in
            PetManager.shared.allPets {

            if PetManager.shared.isOwned(pet) {

                text +=
                    "🟢 \(pet.name) " +
                    "\(pet.rarityText)\n\n"

            } else {

                text +=
                    "🔒 ??? " +
                    "\(pet.rarityText)\n\n"
            }
        }

        textView.text =
            text
    }

    @objc private func selectPet() {

        navigationController?.pushViewController(
            PetSelectViewController(),
            animated: true
        )
    }
}