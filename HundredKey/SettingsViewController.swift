//
//  SettingsViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

//
//  SettingsViewController.swift
//  Hundred_Key
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var pointLabel: UILabel!

    @IBOutlet weak var bgmSwitch: UISwitch!

    @IBOutlet weak var soundSwitch: UISwitch!


    override func viewDidLoad() {
        super.viewDidLoad()

        loadSettings()
    }


    override func viewWillAppear(
        _ animated: Bool
    ) {

        super.viewWillAppear(animated)

        loadSettings()
    }


    private func loadSettings() {

        nameTextField.text =
            UserDefaults.standard.string(
                forKey: "USER_NAME"
            ) ?? ""


        pointLabel.text =
            "現在のポイント：\(PointManager.shared.point) pt"


        bgmSwitch.isOn =
            UserDefaults.standard.object(
                forKey: "BGM_ON"
            ) as? Bool ?? true


        soundSwitch.isOn =
            UserDefaults.standard.object(
                forKey: "SOUND_ON"
            ) as? Bool ?? true
    }


    // MARK: - 名前保存

    @IBAction func saveNameButtonTapped(
        _ sender: UIButton
    ) {

        guard let text =
                nameTextField.text
        else {
            return
        }


        let newName =
            text.trimmingCharacters(
                in: .whitespacesAndNewlines
            )


        if newName.isEmpty {

            showAlert(
                title: "名前を入力してね",
                message: "名前が空欄です。"
            )

            return
        }


        let oldName =
            UserDefaults.standard.string(
                forKey: "USER_NAME"
            ) ?? ""


        let point =
            PointManager.shared.point


        UserDefaults.standard.set(
            newName,
            forKey: "USER_NAME"
        )


        RankingManager.shared.changeName(
            oldName: oldName,
            newName: newName,
            point: point
        )


        showAlert(
            title: "保存しました",
            message: "名前を変更しました。"
        )
    }


    // MARK: - BGM

    @IBAction func bgmSwitchChanged(
        _ sender: UISwitch
    ) {

        UserDefaults.standard.set(
            sender.isOn,
            forKey: "BGM_ON"
        )


        if sender.isOn {

            BGMManager.shared.playBGM()

        } else {

            BGMManager.shared.stopBGM()
        }
    }


    // MARK: - 効果音

    @IBAction func soundSwitchChanged(
        _ sender: UISwitch
    ) {

        UserDefaults.standard.set(
            sender.isOn,
            forKey: "SOUND_ON"
        )
    }


    // MARK: - データリセット

    @IBAction func resetButtonTapped(
        _ sender: UIButton
    ) {

        let alert =
            UIAlertController(
                title: "データリセット",
                message:
                    "すべてのデータを削除しますか？",
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

                PointManager.shared.reset()

                PetManager.shared.reset()

                RankingManager.shared.resetRanking()

                UserDefaults.standard.removeObject(
                    forKey: "USER_NAME"
                )


                self.loadSettings()


                self.showAlert(
                    title: "リセット完了",
                    message: "データをリセットしました。"
                )
            }
        )


        present(
            alert,
            animated: true
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
