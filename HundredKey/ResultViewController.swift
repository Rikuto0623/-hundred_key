//
//  ResultViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

//
//  ResultViewController.swift
//  Hundred_Key
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultTitleLabel: UILabel!

    @IBOutlet weak var correctCountLabel: UILabel!

    @IBOutlet weak var accuracyLabel: UILabel!

    @IBOutlet weak var pointLabel: UILabel!

    @IBOutlet weak var petImageView: UIImageView!

    @IBOutlet weak var petNameLabel: UILabel!

    @IBOutlet weak var homeButton: UIButton!

    @IBOutlet weak var gachaButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        showResult()

        BGMManager.shared.playBGM()
    }


    private func showResult() {

        let session =
            GameSession.shared


        let correct =
            session.correctCount


        let total =
            session.totalQuestions


        let accuracy =
            total > 0
            ? Int(
                Double(correct)
                / Double(total)
                * 100
            )
            : 0


        let earnedPoint =
            correct * 10


        correctCountLabel.text =
            "正解数　\(correct) / \(total) 問"


        accuracyLabel.text =
            "正解率　\(accuracy) %"


        pointLabel.text =
            "獲得ポイント　+\(earnedPoint) pt"


        if let pet =
            PetManager.shared.selectedPet {

            petNameLabel.text =
                pet.name

            petImageView.image =
                UIImage(
                    named: pet.imageName
                )
        }


        if !session.resultSaved {

            PointManager.shared.add(
                earnedPoint
            )


            let name =
                UserDefaults.standard.string(
                    forKey: "USER_NAME"
                ) ?? "ゲスト"


            RankingManager.shared.updatePoint(
                name: name,
                point: PointManager.shared.point
            )


            session.resultSaved = true
        }
    }


    @IBAction func homeButtonTapped(
        _ sender: UIButton
    ) {

        navigationController?
            .popToRootViewController(
                animated: true
            )
    }


    @IBAction func gachaButtonTapped(
        _ sender: UIButton
    ) {

        performSegue(
            withIdentifier: "toGacha",
            sender: nil
        )
    }
}
