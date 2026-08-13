//
//  RankingUser.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  RankingManager.swift
//  Hundred_Key
//

import Foundation

struct RankingUser: Codable {

    var name: String
    var point: Int
}


final class RankingManager {

    static let shared = RankingManager()

    private init() {}

    private let rankingKey = "RANKING"


    var users: [RankingUser] {

        get {

            guard let data =
                    UserDefaults.standard.data(
                        forKey: rankingKey
                    )
            else {
                return []
            }

            do {

                return try JSONDecoder().decode(
                    [RankingUser].self,
                    from: data
                )

            } catch {

                print("ランキング読み込みエラー")
                return []
            }
        }

        set {

            do {

                let data =
                    try JSONEncoder().encode(newValue)

                UserDefaults.standard.set(
                    data,
                    forKey: rankingKey
                )

            } catch {

                print("ランキング保存エラー")
            }
        }
    }


    // MARK: - 新規ユーザー

    func registerUser(
        name: String
    ) {

        var list = users

        if list.contains(
            where: { $0.name == name }
        ) {
            return
        }

        list.append(
            RankingUser(
                name: name,
                point: 0
            )
        )

        sortAndSave(list)
    }


    // MARK: - ポイント更新

    func updatePoint(
        name: String,
        point: Int
    ) {

        var list = users

        if let index =
            list.firstIndex(
                where: { $0.name == name }
            ) {

            list[index].point = point

        } else {

            list.append(
                RankingUser(
                    name: name,
                    point: point
                )
            )
        }

        sortAndSave(list)
    }


    // MARK: - 名前変更

    func changeName(
        oldName: String,
        newName: String,
        point: Int
    ) {

        var list = users

        list.removeAll {
            $0.name == oldName
        }

        list.append(
            RankingUser(
                name: newName,
                point: point
            )
        )

        sortAndSave(list)
    }


    private func sortAndSave(
        _ list: [RankingUser]
    ) {

        var sorted = list

        sorted.sort {
            $0.point > $1.point
        }

        users = sorted
    }


    func resetRanking() {

        UserDefaults.standard.removeObject(
            forKey: rankingKey
        )
    }
}