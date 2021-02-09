//
//  GeographicalQuizResultsViewController.swift
//  QuizTP
//
//  Created by Yannis MEKAOUCHE on 08/02/2021.
//

import UIKit
import Lottie


class GeographicalQuizResultsViewController: UIViewController {
    @IBOutlet var checkAnimation: AnimationView!
    @IBOutlet var quizScoreUiLabel: UILabel!
    
    var quizScore: Int = 0
    
    override func viewDidLoad() {

      super.viewDidLoad()
      
        super.viewDidLoad()
        
        checkAnimation.contentMode = .scaleAspectFit
        checkAnimation.loopMode = .loop
        checkAnimation.animationSpeed = 1
        checkAnimation.play()
        
        quizScoreUiLabel.text = String(quizScore)
    }
    
    @IBAction func goBackToQuizButton(_ sender: Any) {
        self.navigationController?.pushViewController(CategoriesViewController(), animated: true)
    }
}
