//
//  RankingViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//


//
//  RankingViewController.swift
//  Hundred_Key
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet weak var rankingTableView: UITableView!


    private var rankingUsers:
        [RankingUser] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        rankingTableView.delegate =
            self

        rankingTableView.dataSource =
            self

        rankingTableView.rowHeight =
            60

        loadRanking()
    }


    override func viewWillAppear(
        _ animated: Bool
    ) {

        super.viewWillAppear(animated)

        loadRanking()
    }


    private func loadRanking() {

        rankingUsers =
            RankingManager.shared.users

        rankingUsers.sort {
            $0.point > $1.point
        }

        rankingTableView.reloadData()
    }
}


extension RankingViewController:
    UITableViewDelegate,
    UITableViewDataSource {


    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return rankingUsers.count
    }


    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier:
                    "RankingCell",
                for: indexPath
            )


        let user =
            rankingUsers[indexPath.row]


        let rank =
            indexPath.row + 1


        switch rank {

        case 1:

            cell.textLabel?.text =
                "👑 1位　\(user.name)　\(user.point) pt"

        case 2:

            cell.textLabel?.text =
                "🥈 2位　\(user.name)　\(user.point) pt"

        case 3:

            cell.textLabel?.text =
                "🥉 3位　\(user.name)　\(user.point) pt"

        default:

            cell.textLabel?.text =
                "\(rank)位　\(user.name)　\(user.point) pt"
        }


        return cell
    }
}