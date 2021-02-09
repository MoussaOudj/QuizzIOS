//
//  QuestionService.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 27/12/2020.
//

import Foundation
protocol QuestionService {
    func getQuestionFor(categorie:String, completionHandler: @escaping (_ result: Question?) -> Void)
}
