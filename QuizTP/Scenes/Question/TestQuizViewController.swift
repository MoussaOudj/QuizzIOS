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
    let httpQuestionService = HttpQuestionService()
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
    
    fileprivate func requestQuestion() {
        httpQuestionService.getQuestionFor(categorie: self.theme) { (question) in
            print("=== LABEL TEXT QUESTION : \(question) ===")
            DispatchQueue.main.async {
                self.updateQuestion( question)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        requestQuestion()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
                requestQuestion()
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


