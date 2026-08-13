//
//  PetBookViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  PetBookViewController.swift
//  Hundred_Key
//

import UIKit

class PetBookViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier:
                "PetCell"
        )
    }


    override func viewWillAppear(
        _ animated: Bool
    ) {

        super.viewWillAppear(animated)

        collectionView.reloadData()
    }
}


// MARK: - UICollectionView

extension PetBookViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource {


    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        return PetManager.shared.allPets.count
    }


    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier:
                    "PetCell",
                for: indexPath
            )


        let pet =
            PetManager.shared.allPets[
                indexPath.item
            ]


        // 既存のImageViewを削除
        cell.contentView.subviews.forEach {
            $0.removeFromSuperview()
        }


        let imageView =
            UIImageView(
                frame: CGRect(
                    x: 10,
                    y: 5,
                    width: 80,
                    height: 80
                )
            )


        imageView.contentMode =
            .scaleAspectFit


        if PetManager.shared.hasPet(pet) {

            imageView.image =
                UIImage(
                    named: pet.imageName
                )

        } else {

            imageView.image =
                UIImage(
                    systemName: "questionmark"
                )
        }


        cell.contentView.addSubview(
            imageView
        )


        return cell
    }


    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {

        let pet =
            PetManager.shared.allPets[
                indexPath.item
            ]


        if PetManager.shared.hasPet(pet) {

            performSegue(
                withIdentifier: "toPetDetail",
                sender: pet
            )
        }
    }


    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {

        if let detailVC =
            segue.destination
                as? PetDetailViewController {

            detailVC.pet =
                sender as? Pet
        }
    }
}