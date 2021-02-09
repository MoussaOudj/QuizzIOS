//
//  HttpQuestionService.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 27/12/2020.
//

import Foundation
public class HttpQuestionService:QuestionService{
    func getQuestionFor(categorie: String, completionHandler: @escaping (Question?) -> Void) {
        let url = URL(string: "https://www.openquizzdb.org/api.php?key=74G62ZDZZ8&categ=\(categorie)&anec=1")!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print("ERROR")
                return
            }
            guard let data = data else {
                return
            }
            do {
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
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
}
