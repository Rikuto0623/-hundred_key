//
//  HomeViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  HomeViewController.swift
//  Hundred_Key
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var pointLabel: UILabel!

    @IBOutlet weak var petImageView: UIImageView!

    @IBOutlet weak var petNameLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        PetManager.shared.setupDefaultPet()

        updateHome()

        BGMManager.shared.playBGM()
    }


    override func viewWillAppear(
        _ animated: Bool
    ) {

        super.viewWillAppear(animated)

        updateHome()

        BGMManager.shared.playBGM()
    }


    private func updateHome() {

        let name =
            UserDefaults.standard.string(
                forKey: "USER_NAME"
            ) ?? "ゲスト"


        nameLabel.text =
            "\(name)さん"


        pointLabel.text =
            "\(PointManager.shared.point) pt"


        if let pet =
            PetManager.shared.selectedPet {

            petNameLabel.text =
                pet.name

            petImageView.image =
                UIImage(
                    named: pet.imageName
                )
        }
    }


    // MARK: - ゲーム開始

    @IBAction func gameStartButtonTapped(
        _ sender: UIButton
    ) {

        GameSession.shared.startGame()

        performSegue(
            withIdentifier: "toQuiz",
            sender: nil
        )
    }


    // MARK: - ガチャ

    @IBAction func gachaButtonTapped(
        _ sender: UIButton
    ) {

        performSegue(
            withIdentifier: "toGacha",
            sender: nil
        )
    }


    // MARK: - 図鑑

    @IBAction func petBookButtonTapped(
        _ sender: UIButton
    ) {

        performSegue(
            withIdentifier: "toPetBook",
            sender: nil
        )
    }


    // MARK: - ランキング

    @IBAction func rankingButtonTapped(
        _ sender: UIButton
    ) {

        performSegue(
            withIdentifier: "toRanking",
            sender: nil
        )
    }


    // MARK: - 設定

    @IBAction func settingsButtonTapped(
        _ sender: UIButton
    ) {

        performSegue(
            withIdentifier: "toSettings",
            sender: nil
        )
    }
}