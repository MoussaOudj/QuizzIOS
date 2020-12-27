//
//  AnswerCollectionViewCell.swift
//  QuizQuiz
//
//  Created by OUDJAMA Moussa (Canal Plus) on 25/12/2020.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var answer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //0, 80, 157
        self.backgroundColor = .init(red: 0, green: 80/255, blue: 157/255, alpha: 1)
        //255, 213, 0
        self.answer.textColor = .init(red: 1, green: 213/255, blue: 0, alpha: 1)
    }

}
