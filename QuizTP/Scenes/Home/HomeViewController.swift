//
//  HomeViewController.swift
//  QuizQuiz
//
//  Created by OUDJAMA Moussa (Canal Plus) on 22/12/2020.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func goToPlay(_ sender: Any) {
        self.navigationController?.pushViewController(CategoriesViewController(), animated: true)
    }
}
