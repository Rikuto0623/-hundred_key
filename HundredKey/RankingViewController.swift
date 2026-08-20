//
//  RankingViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


import UIKit

final class RankingViewController:
    UIViewController {

    private let textView =
        UITextView()

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "ランキング"

        setupUI()

        showRanking()
    }

    override func viewWillAppear(
        _ animated: Bool
    ) {

        super.viewWillAppear(animated)

        showRanking()
    }

    private func setupUI() {

        textView.isEditable =
            false

        textView.font =
            .boldSystemFont(
                ofSize: 19
            )

        view.addSubview(textView)

        textView.translatesAutoresizingMaskIntoConstraints =
            false

        NSLayoutConstraint.activate([

            textView.topAnchor.constraint(
                equalTo:
                    view.safeAreaLayoutGuide
                    .topAnchor,
                constant: 20
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

    private func showRanking() {

        let ranking =
            UserDefaults.standard.array(
                forKey: "RANKING"
            ) as? [[String: Any]] ?? []

        var text =
            "🏆 ランキング\n\n"

        if ranking.isEmpty {

            text +=
                "まだランキングがありません"

        } else {

            for (
                index,
                item
            ) in ranking.enumerated() {

                let name =
                    item["name"] as? String
                    ?? "ゲスト"

                let point =
                    item["point"] as? Int
                    ?? 0

                let medal: String

                switch index {

                case 0:
                    medal = "👑"

                case 1:
                    medal = "🥈"

                case 2:
                    medal = "🥉"

                default:
                    medal = "\(index + 1)"
                }

                text +=
                    "\(medal) \(name)　\(point) pt\n\n"
            }
        }

        textView.text =
            text
    }
}
