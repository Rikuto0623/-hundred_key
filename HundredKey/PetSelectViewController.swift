//
//  PetSelectViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

import UIKit

final class PetSelectViewController:
    UIViewController {

    private let stack =
        UIStackView()

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "ペット選択"

        setupUI()

        showPets()
    }

    private func setupUI() {

        stack.axis = .vertical

        stack.spacing = 10

        stack.alignment =
            .fill

        view.addSubview(stack)

        stack.translatesAutoresizingMaskIntoConstraints =
            false

        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(
                equalTo:
                    view.safeAreaLayoutGuide
                    .topAnchor,
                constant: 20
            ),

            stack.leadingAnchor.constraint(
                equalTo:
                    view.leadingAnchor,
                constant: 30
            ),

            stack.trailingAnchor.constraint(
                equalTo:
                    view.trailingAnchor,
                constant: -30
            )
        ])
    }

    private func showPets() {

        for pet in
            PetManager.shared.allPets {

            let button =
                UIButton(type: .system)

            let owned =
                PetManager.shared.isOwned(pet)

            button.setTitle(
                owned
                ? "\(pet.name) \(pet.rarityText)"
                : "🔒 ???",
                for: .normal
            )

            button.setTitleColor(
                .label,
                for: .normal
            )

            button.backgroundColor =
                owned
                ? UIColor.systemGreen
                    .withAlphaComponent(0.2)
                : UIColor.systemGray
                    .withAlphaComponent(0.2)

            button.layer.cornerRadius =
                10

            button.heightAnchor.constraint(
                equalToConstant: 48
            ).isActive = true

            button.isEnabled =
                owned

            button.addAction(
                UIAction { _ in

                    PetManager.shared.selectedPetName =
                        pet.name

                    self.navigationController?
                        .popViewController(
                            animated: true
                        )
                },
                for: .touchUpInside
            )

            stack.addArrangedSubview(
                button
            )
        }
    }
}
