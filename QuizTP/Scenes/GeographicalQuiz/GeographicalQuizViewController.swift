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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var questions: [GeographicalQuestions]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quiz Géographique"
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = false
        mapView.mapType = .satellite
        setMapCountry(mapCountry: "FR")
        
        do {
            self.questions = try context.fetch(GeographicalQuestions.fetchRequest())
            for question in self.questions! {
                print(question.countryCode)
            }
        } catch {
            
        }

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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //        requestQuestion()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
