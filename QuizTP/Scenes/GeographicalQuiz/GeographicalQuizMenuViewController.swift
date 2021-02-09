//
//  GeographicalQuizMenuViewController.swift
//  QuizTP
//
//  Created by Yannis MEKAOUCHE on 09/02/2021.
//

import UIKit
import Lottie

class GeographicalQuizMenuViewController: UIViewController {

    @IBOutlet var worldMapAnimation: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        worldMapAnimation.contentMode = .scaleAspectFit
        worldMapAnimation.loopMode = .loop
        worldMapAnimation.animationSpeed = 1
        worldMapAnimation.play()
    }

    @IBAction func goToAfricaQuiz(_ sender: Any) {
        let geographicalQuizViewController = GeographicalQuizViewController(nibName: "GeographicalQuizViewController", bundle: nil)
        
        geographicalQuizViewController.quizCategory = "AFRIQUE"
        navigationController?.pushViewController(geographicalQuizViewController, animated: true)
    }
    
    @IBAction func goToEuropeQuiz(_ sender: Any) {
        let geographicalQuizViewController = GeographicalQuizViewController(nibName: "GeographicalQuizViewController", bundle: nil)
        
        geographicalQuizViewController.quizCategory = "EUROPE"
        navigationController?.pushViewController(geographicalQuizViewController, animated: true)
    }
    
}
