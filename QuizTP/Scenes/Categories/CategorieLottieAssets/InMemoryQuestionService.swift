//
//  InMemoryQuestionService.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 11/02/2021.
//

import Foundation
public class InMemoryQuestionService {
    
    func getQuestionFor(categorie: String, completionHandler: @escaping (Question?) -> Void) {
        
        
        if let path = Bundle.main.path(forResource: categorie, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    guard let results = json["results"] as? [[String:Any]] else {return}
                    print("=== RESULTS ===")
                    print(results)
                    print("=== END RESULTS ===")
                    print("=== QUESTION PROCESSING WITH RESULT COUNT : \(results.count) ===")
                    if(results.count == 0){
                        completionHandler(nil)
                    }else {
                        guard let question = results[0]["question"] as? String else {return}
                        guard let choix = results[0]["autres_choix"] as? [String] else {return}
                        guard let reponse = results[0]["reponse_correcte"] as? String else {return}
                        guard let anecdote = results[0]["anecdote"] as? String else {return}
                        completionHandler(Question(question: question, reponse: reponse, choix: choix,anecdote: anecdote))
                    }
                    print("=== END PROCESSING ===")
                }
            } catch {
                // handle error
            }
        }
    }
}
