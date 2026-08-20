//
//  GachaManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/19.
//


import Foundation

final class GachaManager {

    static let shared = GachaManager()

    private init() {}

    private let drawCountKey =
        "GACHA_DRAW_COUNT"

    private let historyKey =
        "GACHA_HISTORY"

    var drawCount: Int {

        get {

            UserDefaults.standard.integer(
                forKey: drawCountKey
            )
        }

        set {

            UserDefaults.standard.set(
                newValue,
                forKey: drawCountKey
            )
        }
    }

    func draw() -> Pet {

        drawCount += 1

        // 100回目は★5確定
        if drawCount >= 100 {

            drawCount = 0

            let fiveStar =
                PetManager.shared.allPets.filter {
                    $0.rarity == 5
                }

            let pet =
                fiveStar.randomElement()!

            PetManager.shared.addPet(pet)

            saveHistory(pet)

            return pet
        }

        let random =
            Int.random(in: 1...100)

        let pet: Pet

        switch random {

        case 1...2:

            pet =
                PetManager.shared.allPets.filter {
                    $0.rarity == 5
                }.randomElement()!

        case 3...10:

            pet =
                PetManager.shared.allPets.filter {
                    $0.rarity == 4
                }.randomElement()!

        case 11...30:

            pet =
                PetManager.shared.allPets.filter {
                    $0.rarity == 3
                }.randomElement()!

        case 31...60:

            pet =
                PetManager.shared.allPets.filter {
                    $0.rarity == 2
                }.randomElement()!

        default:

            pet =
                PetManager.shared.allPets.filter {
                    $0.rarity == 1
                }.randomElement()!
        }

        PetManager.shared.addPet(pet)

        saveHistory(pet)

        return pet
    }

    func tenDraw() -> [Pet] {

        var results: [Pet] = []

        for _ in 0..<10 {

            results.append(
                draw()
            )
        }

        return results
    }

    private func saveHistory(_ pet: Pet) {

        var history =
            UserDefaults.standard.array(
                forKey: historyKey
            ) as? [[String: Any]] ?? []

        history.append([
            "name": pet.name,
            "rarity": pet.rarity,
            "date": Date().timeIntervalSince1970
        ])

        UserDefaults.standard.set(
            history,
            forKey: historyKey
        )
    }

    func history() -> [GachaHistoryItem] {

        let array =
            UserDefaults.standard.array(
                forKey: historyKey
            ) as? [[String: Any]] ?? []

        return array.compactMap {

            guard
                let name =
                    $0["name"] as? String,
                let rarity =
                    $0["rarity"] as? Int,
                let time =
                    $0["date"] as? Double
            else {
                return nil
            }

            return GachaHistoryItem(
                petName: name,
                rarity: rarity,
                date: Date(
                    timeIntervalSince1970: time
                )
            )
        }
    }
}