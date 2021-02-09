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
        labelText.textColor = .black
        labelText.numberOfLines = 0
        labelText.backgroundColor = .init(red: 33/255, green: 144/255, blue: 241/255, alpha: 0.6)
        labelText.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        self.addSubview(labelText)
    }
}
