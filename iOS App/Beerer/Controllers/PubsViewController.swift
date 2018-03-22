//
//  PubsViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 22/03/18.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import MapKit

class PubsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var managerPosizione: CLLocationManager!
    var posizioneUtente: CLLocationCoordinate2D!
    var localSearchRequest: MKLocalSearchRequest!
    var localSearch: MKLocalSearch!
    var pointAnnotation: MKPointAnnotation!
    var pinAnnotationView: MKPinAnnotationView!

    func showNearbyPub() {
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = "pub"
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "No PubsFound", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.managerPosizione = CLLocationManager()
        managerPosizione.delegate = self
        managerPosizione.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        managerPosizione.requestWhenInUseAuthorization()
        managerPosizione.startUpdatingLocation()
        self.showNearbyPub()

        // Do any additional setup after loading the view.
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.posizioneUtente = userLocation.coordinate
        print("posizione aggiornata - lat: \(userLocation.coordinate.latitude) long: \(userLocation.coordinate.longitude)")
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: posizioneUtente, span: span)
        mapView.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
