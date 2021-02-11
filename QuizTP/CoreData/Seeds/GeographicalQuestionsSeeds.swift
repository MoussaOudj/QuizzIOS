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
         countryCode: "DZA",
         answerA: "Côte d'Ivoire",
         answerB: "Ethiopie",
         answerC: "Algérie",
         answerD: "Nigéria",
         rightAnswer: "Algérie"),
        
        (questionCategory: "AFRIQUE",
         countryCode: "AGO",
         answerA: "Angola",
         answerB: "Botswana",
         answerC: "Somalie",
         answerD: "Tunisie",
         rightAnswer: "Angola"),
        
        (questionCategory: "AFRIQUE",
         countryCode: "MAR",
         answerA: "Tunisie",
         answerB: "Mauritanie",
         answerC: "Madagascar",
         answerD: "Maroc",
         rightAnswer: "Maroc"),
        
        (questionCategory: "AFRIQUE",
         countryCode: "EGY",
         answerA: "Algerie",
         answerB: "Egypte",
         answerC: "Afrique du Sud",
         answerD: "Sénégal",
         rightAnswer: "Egypte"),
        
        (questionCategory: "AFRIQUE",
         countryCode: "ZAF",
         answerA: "Afrique du Sud",
         answerB: "Mozambique",
         answerC: "Botswana",
         answerD: "Namibie",
         rightAnswer: "Afrique du Sud"),
        
        (questionCategory: "EUROPE",
         countryCode: "BEL",
         answerA: "Finlande",
         answerB: "Pays-Bas",
         answerC: "Belgique",
         answerD: "Allemagne",
         rightAnswer: "Belgique"),
        
        (questionCategory: "EUROPE",
         countryCode: "AUT",
         answerA: "Allemagne",
         answerB: "Italie",
         answerC: "Luxembourg",
         answerD: "Autriche",
         rightAnswer: "Autriche"),
        
        (questionCategory: "EUROPE",
         countryCode: "HRV",
         answerA: "Croatie",
         answerB: "Lituanie",
         answerC: "Hongrie",
         answerD: "Roumanie",
         rightAnswer: "Croatie"),
        
        (questionCategory: "EUROPE",
         countryCode: "GRC",
         answerA: "Bulgarie",
         answerB: "Kosovo",
         answerC: "Croatie",
         answerD: "Grèce",
         rightAnswer: "Grèce"),
        
        (questionCategory: "EUROPE",
         countryCode: "SWE",
         answerA: "Norvège",
         answerB: "Suède",
         answerC: "Finlande",
         answerD: "Danemark",
         rightAnswer: "Suède"),
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
