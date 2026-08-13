//
//  Pet.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  PetManager.swift
//  Hundred_Key
//

import Foundation

// MARK: - Pet

struct Pet: Codable {

    let id: String
    let name: String
    let imageName: String
    let rarity: Int
}


// MARK: - PetManager

final class PetManager {

    static let shared = PetManager()

    private init() {}

    // MARK: - UserDefaults Key

    private let ownedPetsKey = "OWNED_PETS"
    private let selectedPetKey = "SELECTED_PET"


    // MARK: - 全ペット

    let allPets: [Pet] = [

        Pet(
            id: "hiyokey",
            name: "ヒヨキー",
            imageName: "Hiyokey",
            rarity: 1
        ),

        Pet(
            id: "rabikey",
            name: "ラビキー",
            imageName: "Rabikey",
            rarity: 1
        ),

        Pet(
            id: "foxie",
            name: "フォクシー",
            imageName: "Foxie",
            rarity: 2
        ),

        Pet(
            id: "pandamu",
            name: "パンダム",
            imageName: "Pandamu",
            rarity: 2
        ),

        Pet(
            id: "penkey",
            name: "ペンキー",
            imageName: "Penkey",
            rarity: 3
        ),

        Pet(
            id: "drakey",
            name: "ドラキー",
            imageName: "Drakey",
            rarity: 3
        ),

        Pet(
            id: "leon",
            name: "レオン",
            imageName: "Leon",
            rarity: 4
        ),

        Pet(
            id: "yuniru",
            name: "ユニル",
            imageName: "Yuniru",
            rarity: 4
        ),

        Pet(
            id: "rainbowMochi",
            name: "レインボーもち",
            imageName: "RainbowMochi",
            rarity: 5
        ),

        Pet(
            id: "kingOmega",
            name: "キングオメガ",
            imageName: "KingOmega",
            rarity: 5
        )
    ]


    // MARK: - 所持ペット

    var ownedPets: [Pet] {

        get {

            guard let data =
                    UserDefaults.standard.data(
                        forKey: ownedPetsKey
                    )
            else {
                return []
            }

            do {

                return try JSONDecoder().decode(
                    [Pet].self,
                    from: data
                )

            } catch {

                print("ペット読み込みエラー")
                return []
            }
        }

        set {

            do {

                let data =
                    try JSONEncoder().encode(newValue)

                UserDefaults.standard.set(
                    data,
                    forKey: ownedPetsKey
                )

            } catch {

                print("ペット保存エラー")
            }
        }
    }


    // MARK: - 選択中ペット

    var selectedPet: Pet? {

        get {

            guard let id =
                    UserDefaults.standard.string(
                        forKey: selectedPetKey
                    )
            else {
                return nil
            }

            return allPets.first {
                $0.id == id
            }
        }

        set {

            if let pet = newValue {

                UserDefaults.standard.set(
                    pet.id,
                    forKey: selectedPetKey
                )

            } else {

                UserDefaults.standard.removeObject(
                    forKey: selectedPetKey
                )
            }
        }
    }


    // MARK: - 初期ペット

    func setupDefaultPet() {

        if ownedPets.isEmpty {

            let hiyokey =
                allPets[0]

            ownedPets = [hiyokey]

            selectedPet =
                hiyokey
        }

        if selectedPet == nil {

            selectedPet =
                ownedPets.first
        }
    }


    // MARK: - 所持確認

    func hasPet(
        _ pet: Pet
    ) -> Bool {

        return ownedPets.contains {
            $0.id == pet.id
        }
    }


    // MARK: - ペット追加

    func addPet(
        _ pet: Pet
    ) {

        if !hasPet(pet) {

            var pets = ownedPets

            pets.append(pet)

            ownedPets = pets
        }
    }


    // MARK: - ペット選択

    func selectPet(
        _ pet: Pet
    ) {

        guard hasPet(pet) else {
            return
        }

        selectedPet = pet
    }


    // MARK: - ペットリセット

    func reset() {

        UserDefaults.standard.removeObject(
            forKey: ownedPetsKey
        )

        UserDefaults.standard.removeObject(
            forKey: selectedPetKey
        )

        setupDefaultPet()
    }
}