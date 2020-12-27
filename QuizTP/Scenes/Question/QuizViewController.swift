//
//  TestQuizViewController.swift
//  QuizQuiz
//
//  Created by OUDJAMA Moussa (Canal Plus) on 23/12/2020.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var collectionAnswerView: UICollectionView!
    let httpQuestionService = HttpQuestionService()
    var answerTable:[String] = []
    var goodAnswer:String?
    var theme:String!
    
    
    static func newInstance(selectedTheme: String) -> QuizViewController {
        let viewController = QuizViewController()
        viewController.theme = selectedTheme
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //0, 63, 136
        self.collectionAnswerView.backgroundColor = .init(red: 0, green: 63/255, blue: 136/255, alpha: 1)
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

extension QuizViewController:UICollectionViewDelegate{
    
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

extension QuizViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answerTable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "answerCell", for: indexPath) as! AnswerCollectionViewCell
        cell.answer.text = answerTable[indexPath.row]
        return cell
    }
}


extension QuizViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionAnswerView.bounds.width/2 - 10, height: self.collectionAnswerView.bounds.height/2 - 10)
    }
}


