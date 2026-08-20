//
//  PetManager.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/17.
//

import Foundation

final class PetManager {

    static let shared = PetManager()

    private init() {}

    let allPets: [Pet] = [

        Pet(
            name: "ヒヨキー",
            rarity: 1,
            imageName: "pet_hiyokey"
        ),

        Pet(
            name: "ラビキー",
            rarity: 1,
            imageName: "pet_rabikey"
        ),

        Pet(
            name: "フォクシー",
            rarity: 2,
            imageName: "pet_foxey"
        ),

        Pet(
            name: "パンダム",
            rarity: 2,
            imageName: "pet_pandam"
        ),

        Pet(
            name: "ペンキー",
            rarity: 3,
            imageName: "pet_penkey"
        ),

        Pet(
            name: "ドラキー",
            rarity: 3,
            imageName: "pet_drakey"
        ),

        Pet(
            name: "レオン",
            rarity: 4,
            imageName: "pet_leon"
        ),

        Pet(
            name: "ユニル",
            rarity: 4,
            imageName: "pet_uniru"
        ),

        Pet(
            name: "ウーパキー",
            rarity: 5,
            imageName: "pet_treasureChest"
        ),

        Pet(
            name: "キングオメガ",
            rarity: 5,
            imageName: "pet_kingomega"
        )
    ]

    var ownedPetNames: [String] {

        get {

            UserDefaults.standard.stringArray(
                forKey: "OWNED_PETS"
            ) ?? ["ヒヨキー"]
        }

        set {

            UserDefaults.standard.set(
                newValue,
                forKey: "OWNED_PETS"
            )
        }
    }

    var selectedPetName: String {

        get {

            UserDefaults.standard.string(
                forKey: "SELECTED_PET"
            ) ?? "ヒヨキー"
        }

        set {

            UserDefaults.standard.set(
                newValue,
                forKey: "SELECTED_PET"
            )
        }
    }

    func pet(named name: String) -> Pet? {

        allPets.first {
            $0.name == name
        }
    }

    func addPet(_ pet: Pet) {

        var pets = ownedPetNames

        if !pets.contains(pet.name) {

            pets.append(pet.name)

            ownedPetNames = pets
        }
    }

    func isOwned(_ pet: Pet) -> Bool {

        ownedPetNames.contains(pet.name)
    }
}
