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

struct Pet {

    let name: String
    let rarity: Int
    let imageName: String

    var rarityText: String {

        String(
            repeating: "⭐️",
            count: rarity
        )
    }
}
