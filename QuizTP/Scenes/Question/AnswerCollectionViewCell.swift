//
//  AnswerCollectionViewCell.swift
//  QuizQuiz
//
//  Created by OUDJAMA Moussa (Canal Plus) on 25/12/2020.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var answer: UILabel!
    
    private struct const {
        static let focusedBackgroundColor = UIColor.brown
        static let focusedTextColor = UIColor.white
        static let defaultBackgroundColor = UIColor.init(red: 0, green: 80/255, blue: 157/255, alpha: 1)
        static let defaultTextColor = UIColor.init(red: 1, green: 213/255, blue: 0, alpha: 1)
    }
    
    #if os(tvOS)
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if self.isFocused {
            self.backgroundColor =  const.focusedBackgroundColor
            self.answer.textColor = const.focusedTextColor
        }else {
            self.backgroundColor = const.defaultBackgroundColor
            self.answer.textColor = const.defaultTextColor
        }
    }
    #endif
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = const.defaultBackgroundColor
        self.answer.textColor = const.defaultTextColor
    }
    
}
