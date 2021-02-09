//
//  GeographicalQuizViewController.swift
//  QuizTP
//
//  Created by Yannis MEKAOUCHE on 24/01/2021.
//

import UIKit
import MapKit

class GeographicalQuizViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var collectionAnswerView: UICollectionView!
    var answerTable: [String?] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var questions: [GeographicalQuestions]?
    var goodAnswer: String?
    var quizCounter: Int = 0
    var quizScore: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quiz Géographique"
        
        self.collectionAnswerView.backgroundColor = UIColor.init(red: 0, green: 63/255, blue: 136/255, alpha: 1)
        self.collectionAnswerView.register(UINib(nibName: "AnswerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "answerCell")
        self.collectionAnswerView.delegate = self
        self.collectionAnswerView.dataSource = self
        
        setupMap()

    }
    
    private func setupMap() {
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = false
        mapView.mapType = .satellite
    }
    
    private func setMapCountry(mapCountry: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = mapCountry

        let search = MKLocalSearch(request: searchRequest)

        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            self.mapView.setRegion(response.boundingRegion, animated: true)
        }
    }
    
    fileprivate func updateQuestion(_ question: GeographicalQuestions) {
        self.answerTable = [question.answerA,question.answerB, question.answerC, question.answerD]
        self.goodAnswer = question.rightAnswer
        setMapCountry(mapCountry: question.countryCode!)
        
        UIView.transition(with: self.collectionAnswerView,
                          duration: 1,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.collectionAnswerView.reloadData()
                            self.collectionAnswerView.isUserInteractionEnabled = true
                          })
    }

    fileprivate func setupQuiz() {
        do {
            self.questions = try context.fetch(GeographicalQuestions.fetchRequest())
        } catch {

        }

        DispatchQueue.main.async {
            if self.questions != nil  {
                self.updateQuestion((self.questions?[self.quizCounter])!)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setupQuiz()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension GeographicalQuizViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let goodAnswer = goodAnswer {
            if answerTable[indexPath.row] == goodAnswer {
                print("BONNE REPONSE")
                quizScore += 1
            }
        }
        self.quizCounter += 1
        if (self.quizCounter < questions!.count) {
            self.updateQuestion((self.questions?[self.quizCounter])!)
        }
        else {
            self.navigationController?.pushViewController(GeographicalQuizResultsViewController(), animated: true)
        }
    }

}

extension GeographicalQuizViewController:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answerTable.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "answerCell", for: indexPath) as! AnswerCollectionViewCell
        cell.answer.text = answerTable[indexPath.row]
        return cell
    }
}


extension GeographicalQuizViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionAnswerView.bounds.width/2 - 10, height: self.collectionAnswerView.bounds.height/2 - 10)
    }
}


