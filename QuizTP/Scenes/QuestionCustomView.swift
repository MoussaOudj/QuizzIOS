//
//  QuestionCustomView.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 09/02/2021.
//

import Foundation
import UIKit
import Lottie

public class QuestionCustomView:UIView{
    
    var questionText:String?
    
    public override func draw(_ rect: CGRect) {
        let labelText = UILabel()
        labelText.text = self.questionText
        labelText.textAlignment = .center
        labelText.textColor = .darkGray
        labelText.numberOfLines = 0
        labelText.backgroundColor = UIColor.init(red: 1, green: 247/255, blue: 227/255, alpha: 0.5)
        labelText.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        self.addSubview(labelText)
    }
}
