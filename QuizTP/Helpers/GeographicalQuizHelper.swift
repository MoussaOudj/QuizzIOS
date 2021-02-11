//
//  GeographicalQuizHelper.swift
//  QuizTP
//
//  Created by Yannis MEKAOUCHE on 11/02/2021.
//

import Foundation
import MapKit
import CoreData
var countryFound : Bool = false

public func setMapCountry(mapCountry: String, mapView: MKMapView!) -> Bool {
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery = mapCountry
    
    let search = MKLocalSearch(request: searchRequest)
    
    search.start { response, error in
        guard let response = response else {
            print("Error: \(error?.localizedDescription ?? "Unknown error").")
            return
        }
        countryFound = true
        print(countryFound)
        mapView.setRegion(response.boundingRegion, animated: true)
    }
    
    return countryFound
}
