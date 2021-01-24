//
//  GeographicalQuestions.swift
//  QuizTP
//
//  Created by Yannis MEKAOUCHE on 24/01/2021.
//

import Foundation
import CoreData

public class DataHelper {
    
    
    let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    let questions = [
        (questionCategory: "AFRIQUE",
         countryCode: "DZ",
         answerA: "Côte d'Ivoire",
         answerB: "Ethiopie",
         answerC: "Algérie",
         answerD: "Nigéria",
         rightAnswer: "Algérie"),
        
        (questionCategory: "AFRIQUE",
         countryCode: "AO",
         answerA: "Angola",
         answerB: "Botswana",
         answerC: "Somalie",
         answerD: "Tunisie",
         rightAnswer: "Angola")
    ]
    
    private func cleanGeographicalQuestionsEntity() {
        do {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: GeographicalQuestions.fetchRequest())
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    public func launchSeeds() {
        cleanGeographicalQuestionsEntity()
        for question in questions {
            let newQuestion = NSEntityDescription.insertNewObject(forEntityName: "GeographicalQuestions", into: context) as! GeographicalQuestions
            
            newQuestion.questionCategory = question.questionCategory
            newQuestion.countryCode = question.countryCode
            
            newQuestion.answerA = question.answerA
            newQuestion.answerB = question.answerB
            newQuestion.answerC = question.answerC
            newQuestion.answerD = question.answerD
            
            newQuestion.rightAnswer = question.rightAnswer
        }
        
        do {
            try context.save()
        } catch _ {
            
        }
    }
}
