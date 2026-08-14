//
//  CorrectViewController.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

import UIKit

class CorrectViewController: UIViewController {

    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!

    var correctAnswer: Int = 0

    // QuizViewを保持
    weak var quizViewController: QuizViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        correctAnswerLabel.text =
            "正解！\n答えは \(correctAnswer)"

        showPet()
    }

    private func showPet() {

        guard let pet =
            PetManager.shared.selectedPet else {
            return
        }

        petImageView.image =
            UIImage(named: pet.imageName)
    }

    @IBAction func nextButtonTapped(
        _ sender: UIButton
    ) {

        // QuizViewに戻る
        dismiss(animated: true) {

            self.quizViewController?.showNextQuestion()
        }
    }
}
