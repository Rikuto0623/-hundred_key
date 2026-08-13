//
//  PetSelectViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  PetSelectViewController.swift
//  Hundred_Key
//

import UIKit

class PetSelectViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!


    private var pets: [Pet] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        pets =
            PetManager.shared.ownedPets
    }


    override func viewWillAppear(
        _ animated: Bool
    ) {

        super.viewWillAppear(animated)

        pets =
            PetManager.shared.ownedPets

        tableView.reloadData()
    }
}


extension PetSelectViewController:
    UITableViewDelegate,
    UITableViewDataSource {


    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return pets.count
    }


    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier:
                    "PetSelectCell",
                for: indexPath
            )


        let pet =
            pets[indexPath.row]


        cell.textLabel?.text =
            "\(pet.name)  \(String(repeating: "★", count: pet.rarity))"


        if let image =
            UIImage(
                named: pet.imageName
            ) {

            cell.imageView?.image =
                image
        }


        if PetManager.shared.selectedPet?.id
            == pet.id {

            cell.accessoryType =
                .checkmark

        } else {

            cell.accessoryType =
                .none
        }


        return cell
    }


    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let pet =
            pets[indexPath.row]


        PetManager.shared.selectPet(
            pet
        )


        tableView.reloadData()
    }
}