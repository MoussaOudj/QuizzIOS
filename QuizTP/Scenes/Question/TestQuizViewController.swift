//
//  TestQuizViewController.swift
//  QuizQuiz
//
//  Created by OUDJAMA Moussa (Canal Plus) on 23/12/2020.
//

import UIKit

class TestQuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var collectionAnswerView: UICollectionView!
    var answerTable:[String] = []
    var goodAnswer:String?
    var theme:String!
    
    
    static func newInstance(selectedTheme: String) -> TestQuizViewController {
        let viewController = TestQuizViewController()
        viewController.theme = selectedTheme
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionAnswerView.register(UINib(nibName: "AnswerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "answerCell")
        self.collectionAnswerView.delegate = self
        self.collectionAnswerView.dataSource = self
    }
    
    
    
    fileprivate func updateQuestion(_ question:Question) {
        self.questionLabel.text = question.question
        self.answerTable = question.choix
        self.goodAnswer = question.reponse
        self.collectionAnswerView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        requestForQuestion { (question) in
            print("=== LABEL TEXT QUESTION : \(question) ===")
            DispatchQueue.main.async {
                self.updateQuestion( question)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func requestForQuestion(completionHandler: @escaping (_ result: Question) -> Void ){
        //create the url with NSURL
        let url = URL(string: "https://www.openquizzdb.org/api.php?key=74G62ZDZZ8&categ=\(self.theme ?? "")")! //change the url
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
    
    @IBAction func requester(_ sender: Any) {
        //task.cancel()
        //task.resume()
    }
}

extension TestQuizViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(answerTable[indexPath.row])
        if let goodAnswer = goodAnswer {
            if answerTable[indexPath.row] == goodAnswer {
                print("BONNE REPONSE !!!")
                requestForQuestion { (question) in
                    print("=== LABEL TEXT QUESTION : \(question) ===")
                    DispatchQueue.main.async {
                        self.updateQuestion( question)
                    }
                }
            }
        }
    }
    
}

extension TestQuizViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answerTable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "answerCell", for: indexPath) as! AnswerCollectionViewCell
        cell.answer.text = answerTable[indexPath.row]
        return cell
    }
    
    
}


