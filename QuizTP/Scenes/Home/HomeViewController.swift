//
//  HomeViewController.swift
//  QuizQuiz
//
//  Created by OUDJAMA Moussa (Canal Plus) on 22/12/2020.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    #if os(tvOS)
    @IBOutlet weak var homeTVOS: AnimationView!
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        #if os(tvOS)
        self.homeTVOS.play()
        #endif
    }

    @IBAction func goToPlay(_ sender: Any) {
        self.navigationController?.pushViewController(CategoriesViewController(), animated: true)
    }
}
