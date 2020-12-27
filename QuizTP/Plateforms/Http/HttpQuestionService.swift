//
//  HttpQuestionService.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 27/12/2020.
//

import Foundation
public class HttpQuestionService:QuestionService{
    func getQuestionFor(categorie: String, completionHandler: @escaping (Question) -> Void) {
       
        //create the url with NSURL
        let url = URL(string: "https://www.openquizzdb.org/api.php?key=74G62ZDZZ8&categ=\(categorie)")! //change the url
        //create the session object
        let session = URLSession.shared
        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print("ERROR")
                return
            }
            guard let data = data else {
                return
            }
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    guard let results = json["results"] as? [[String:Any]] else {return}
                    print("=== RESULTS ===")
                    print(results)
                    print("=== END RESULTS ===")
                    print("=== QUESTION PROCESSING WITH RESULT COUNT : \(results.count) ===")
                    if(results.count == 0){
                    }else {
                        guard let question = results[0]["question"] as? String else {return}
                        guard let choix = results[0]["autres_choix"] as? [String] else {return}
                        guard let reponse = results[0]["reponse_correcte"] as? String else {return}
                        completionHandler(Question(question: question, reponse: reponse, choix: choix))
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
