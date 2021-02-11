//
//  TestQuizViewController.swift
//  QuizQuiz
//
//  Created by OUDJAMA Moussa (Canal Plus) on 23/12/2020.
//

import UIKit
import Lottie

class QuizViewController: UIViewController {
    
    
    @IBOutlet weak var questionView: QuestionCustomView!
    @IBOutlet weak var collectionAnswerView: UICollectionView!
    let httpQuestionService = HttpQuestionService()
    var answerTable:[String] = []
    var goodAnswer:String?
    var anecdote:String?
    var theme:String!
    
    private struct const {
        static let questionTransitionDuration:TimeInterval = 2
        static let answerTransitionDuration:TimeInterval = 1
        static let neededRowCellNumber:CGFloat = 2
        static let neededColumnCellNumber:CGFloat = 2
        static let cellPadding:CGFloat = 10
    }
    
    
    static func newInstance(selectedTheme: String) -> QuizViewController {
        let viewController = QuizViewController()
        viewController.theme = selectedTheme
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionAnswerView.register(UINib(nibName: "AnswerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "answerCell")
        self.collectionAnswerView.delegate = self
        self.collectionAnswerView.dataSource = self
        collectionAnswerView.backgroundColor = .clear
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        questionView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        questionView.setNeedsDisplay()
    }
    
    
    
    fileprivate func updateQuestion(_ question:Question) {
        
        self.answerTable = question.choix
        self.goodAnswer = question.reponse
        self.anecdote = question.anecdote
        
        UIView.transition(with: self.questionView,
                          duration: const.questionTransitionDuration,
                          options: .transitionCurlUp,
                          animations: {
                            self.questionView.subviews.forEach { (view) in
                                view.removeFromSuperview()
                            }
                            self.questionView.questionText = question.question
                            self.questionView.setNeedsDisplay()
                          }, completion: nil)
        
        UIView.transition(with: self.collectionAnswerView,
                          duration: const.answerTransitionDuration,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.collectionAnswerView.reloadData()
                            self.collectionAnswerView.isUserInteractionEnabled = true
                          })
    }
    
    fileprivate func requestQuestion() {
        httpQuestionService.getQuestionFor(categorie: self.theme) { (question) in
            guard let quest = question else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                    self.requestQuestion()
                }
                return
            }
            print("=== LABEL TEXT QUESTION : \(quest) ===")
            DispatchQueue.main.async {
                self.updateQuestion(quest)
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
}

extension QuizViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(answerTable[indexPath.row])
        if let goodAnswer = goodAnswer {
            
            if answerTable[indexPath.row] == goodAnswer {
                questionView.subviews.forEach { (view) in
                    view.removeFromSuperview()
                }
                questionView.isHidden = true
                UIView.transition(with: self.questionView,
                                  duration: 3,
                                  options: .transitionFlipFromBottom,
                                  animations: {
                                    let animationView = AnimationView.init(name: "check")
                                    animationView.frame = self.questionView.bounds
                                    animationView.contentMode = .scaleAspectFit
                                    animationView.loopMode = .loop
                                    animationView.animationSpeed = 1
                                    animationView.play()
                                    self.questionView.addSubview(animationView)
                                    self.questionView.isHidden = false
                                    self.collectionAnswerView.isUserInteractionEnabled = false
                                    self.answerTable = ["","","",""]
                                    self.collectionAnswerView.reloadData()
                                  }) { (isFinish) in
                    if isFinish { //Les Églises catholique et orthodoxe accordent une place essentielle à Marie
                        UIView.transition(with: self.questionView,
                                          duration: 3,
                                          options: .transitionFlipFromBottom,
                                          animations: {
                                            self.questionView.subviews.forEach { (view) in
                                                view.removeFromSuperview()
                                            }
                                            self.questionView.questionText = self.anecdote
                                            self.questionView.setNeedsDisplay()
                                          }) { (isFinish) in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                if isFinish {
                                    self.requestQuestion()
                                }
                            }
                            
                        }
                    }
                }
            }else{
                questionView.subviews.forEach { (view) in
                    view.removeFromSuperview()
                }
                UIView.transition(with: self.questionView,
                                  duration: 3,
                                  options: .transitionFlipFromBottom,
                                  animations: {
                                    self.collectionAnswerView.isUserInteractionEnabled = false
                                    self.answerTable = ["","","",""]
                                    self.collectionAnswerView.reloadData()
                                  }) { (isFinish) in
                    if isFinish {
                        let animationView = AnimationView.init(name: "error")
                        animationView.frame = self.questionView.bounds
                        animationView.contentMode = .scaleAspectFit
                        animationView.loopMode = .playOnce
                        animationView.animationSpeed = 1
                        animationView.play()
                        self.questionView.addSubview(animationView)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
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
        return CGSize(width: self.collectionAnswerView.bounds.width/const.neededRowCellNumber - const.cellPadding, height: self.collectionAnswerView.bounds.height/const.neededColumnCellNumber - const.cellPadding)
    }
}
