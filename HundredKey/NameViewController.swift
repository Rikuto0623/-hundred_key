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

class NameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.text =
            "名前を入力してね"
    }


    @IBAction func startButtonTapped(
        _ sender: UIButton
    ) {

        guard let text =
                nameTextField.text
        else {
            return
        }


        let name =
            text.trimmingCharacters(
                in: .whitespacesAndNewlines
            )


        if name.isEmpty {

            showAlert(
                title: "名前を入力してね",
                message: "名前が入力されていません。"
            )

            return
        }


        UserDefaults.standard.set(
            name,
            forKey: "USER_NAME"
        )


        RankingManager.shared.registerUser(
            name: name
        )


        PetManager.shared.setupDefaultPet()


        performSegue(
            withIdentifier: "toHome",
            sender: nil
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
