//
//  File.swift
//  QuizQuiz
//
//  Created by OUDJAMA Moussa (Canal Plus) on 25/12/2020.
//

import Foundation
public class Question {
    
    /*{
     "langue": "fr",
     "categorie": "musique",
     "theme": "Chanteurs",
     "difficulte": "débutant",
     "question": "Sous quel nom le rappeur et homme d'affaires américain Curtis Jackson fait-il carrière ?",
     "reponse_correcte": "50 cent",
     "autres_choix": [
       "50 cent",
       "Mike D",
       "Fat Joe",
       "Big Sean"
     ]
   }*/
    
    var question:String
    var reponse:String
    var anecdote:String
    var choix:[String]
    
    init(question:String,reponse:String,choix:[String],anecdote:String) {
        self.question = question
        self.reponse = reponse
        self.choix = choix
        self.anecdote = anecdote
    } 
    
}
