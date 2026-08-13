//
//  PetDetailViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  PetDetailViewController.swift
//  Hundred_Key
//

import UIKit

class PetDetailViewController: UIViewController {

    var pet: Pet?


    @IBOutlet weak var petImageView: UIImageView!

    @IBOutlet weak var petNameLabel: UILabel!

    @IBOutlet weak var rarityLabel: UILabel!

    @IBOutlet weak var selectButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        guard let pet = pet else {
            return
        }


        petImageView.image =
            UIImage(
                named: pet.imageName
            )


        petNameLabel.text =
            pet.name


        rarityLabel.text =
            String(
                repeating: "★",
                count: pet.rarity
            )


        selectButton.setTitle(
            "選択する",
            for: .normal
        )
    }


    @IBAction func selectButtonTapped(
        _ sender: UIButton
    ) {

        guard let pet = pet else {
            return
        }


        PetManager.shared.selectPet(
            pet
        )


        showAlert(
            title: "選択しました",
            message: "\(pet.name)を選択しました！"
        )
    }


    private func showAlert(
        title: String,
        message: String
    ) {

        let alert =
            UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )


        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )


        present(
            alert,
            animated: true
        )
    }
}