//
//  GeographicalQuizResultsViewController.swift
//  QuizTP
//
//  Created by Yannis MEKAOUCHE on 08/02/2021.
//

import UIKit
import Lottie


class GeographicalQuizResultsViewController: UIViewController {
    
    @IBOutlet var clapAnimation: AnimationView!
    
    @IBOutlet var quizScoreUiLabel: UILabel!
    
    var quizScore: Int = 0
    
    override func viewDidLoad() {

      super.viewDidLoad()
      
        super.viewDidLoad()
        
        clapAnimation.contentMode = .scaleAspectFit
        clapAnimation.loopMode = .loop
        clapAnimation.animationSpeed = 1
        clapAnimation.play()
        
        quizScoreUiLabel.text = String(quizScore)
    }
    
    @IBAction func goBackToQuizButton(_ sender: Any) {
        self.navigationController?.pushViewController(CategoriesViewController(), animated: true)

    }
}
