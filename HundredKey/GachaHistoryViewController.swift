//
//  GachaHistoryViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/19.
//


import UIKit

final class GachaHistoryViewController:
    UIViewController {

    private let textView =
        UITextView()

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "ガチャ履歴"

        setupUI()

        showHistory()
    }

    private func setupUI() {

        textView.isEditable =
            false

        textView.font =
            .systemFont(
                ofSize: 18
            )

        view.addSubview(textView)

        textView.translatesAutoresizingMaskIntoConstraints =
            false

        NSLayoutConstraint.activate([

            textView.topAnchor.constraint(
                equalTo:
                    view.safeAreaLayoutGuide
                    .topAnchor
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
                    view.bottomAnchor
            )
        ])
    }

    private func showHistory() {

        let history =
            GachaManager.shared.history()

        if history.isEmpty {

            textView.text =
                "まだガチャ履歴はありません"

            return
        }

        var text =
            "🎰 ガチャ履歴\n\n"

        for item in history.reversed() {

            text +=
                "\(item.petName) " +
                "\(String(repeating: "⭐️", count: item.rarity))\n"
        }

        textView.text =
            text
    }
}