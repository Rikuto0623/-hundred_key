//
//  GachaViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  GachaViewController.swift
//  Hundred_Key
//

import UIKit

class GachaViewController: UIViewController {

    @IBOutlet weak var pointLabel: UILabel!

    @IBOutlet weak var capsuleImageView: UIImageView!

    @IBOutlet weak var resultImageView: UIImageView!

    @IBOutlet weak var resultNameLabel: UILabel!

    @IBOutlet weak var resultRarityLabel: UILabel!

    @IBOutlet weak var gachaButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        resultImageView.isHidden = true
        resultNameLabel.isHidden = true
        resultRarityLabel.isHidden = true

        updatePoint()
    }


    override func viewWillAppear(
        _ animated: Bool
    ) {

        super.viewWillAppear(animated)

        updatePoint()
    }


    private func updatePoint() {

        pointLabel.text =
            "\(PointManager.shared.point) pt"
    }


    @IBAction func gachaButtonTapped(
        _ sender: UIButton
    ) {

        let cost = 10


        if PointManager.shared.point < cost {

            showAlert(
                title: "ポイント不足",
                message: "ガチャには10pt必要だよ。"
            )

            return
        }


        PointManager.shared.subtract(
            cost
        )


        // ガチャ抽選
        let pet =
            drawPet()


        // ペット登録
        PetManager.shared.addPet(
            pet
        )


        showResult(
            pet: pet
        )


        updatePoint()
    }


    private func drawPet() -> Pet {

        let random =
            Int.random(
                in: 1...100
            )


        if random <= 2 {

            return PetManager.shared.allPets[9]

        } else if random <= 5 {

            return PetManager.shared.allPets[8]

        } else if random <= 15 {

            return PetManager.shared.allPets[
                Int.random(in: 6...7)
            ]

        } else if random <= 35 {

            return PetManager.shared.allPets[
                Int.random(in: 4...5)
            ]

        } else if random <= 65 {

            return PetManager.shared.allPets[
                Int.random(in: 2...3)
            ]

        } else {

            return PetManager.shared.allPets[
                Int.random(in: 0...1)
            ]
        }
    }


    private func showResult(
        pet: Pet
    ) {

        resultImageView.image =
            UIImage(
                named: pet.imageName
            )

        resultNameLabel.text =
            pet.name

        resultRarityLabel.text =
            String(
                repeating: "★",
                count: pet.rarity
            )


        resultImageView.isHidden = false
        resultNameLabel.isHidden = false
        resultRarityLabel.isHidden = false
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