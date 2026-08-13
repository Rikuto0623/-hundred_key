//
//  WrongViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

//
//  WrongViewController.swift
//  Hundred_Key
//

import UIKit

class WrongViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    @IBOutlet weak var answerLabel: UILabel!

    @IBOutlet weak var petImageView: UIImageView!

    @IBOutlet weak var nextButton: UIButton!


    var correctAnswer: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        messageLabel.text =
            "おしい！"

        answerLabel.text =
            "正解は \(correctAnswer) だよ！"

        nextButton.setTitle(
            "次へ",
            for: .normal
        )


        if let pet =
            PetManager.shared.selectedPet {

            petImageView.image =
                UIImage(
                    named: pet.imageName
                )
        }
    }


    @IBAction func nextButtonTapped(
        _ sender: UIButton
    ) {

        if GameSession.shared.isFinished {

            performSegue(
                withIdentifier: "toResult",
                sender: nil
            )

        } else {

            navigationController?
                .popViewController(
                    animated: true
                )
        }
    }
}
