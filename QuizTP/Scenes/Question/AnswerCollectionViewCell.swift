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
        self.backgroundColor = .init(red: 241/255, green: 240/255, blue: 204/255, alpha: 1)
        self.answer.textColor = .init(red: 167/255, green: 29/255, blue: 49/255, alpha: 1)
    }

}
