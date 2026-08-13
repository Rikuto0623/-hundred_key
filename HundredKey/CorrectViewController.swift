//
//  CorrectViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

//
//  CorrectViewController.swift
//  Hundred_Key
//

import UIKit

class CorrectViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    @IBOutlet weak var petImageView: UIImageView!

    @IBOutlet weak var pointLabel: UILabel!

    @IBOutlet weak var nextButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        messageLabel.text =
            "正解！すごい！"

        pointLabel.text =
            "+10 pt"

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
