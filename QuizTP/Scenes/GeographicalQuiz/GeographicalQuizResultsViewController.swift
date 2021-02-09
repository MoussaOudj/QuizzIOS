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

    override func viewDidLoad() {

      super.viewDidLoad()
      
        super.viewDidLoad()
        
        checkAnimation.contentMode = .scaleAspectFit
        checkAnimation.loopMode = .loop
        checkAnimation.animationSpeed = 0.5
        checkAnimation.play()
    }


}
