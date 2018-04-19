//
//  PubsViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 22/03/18.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class PubsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // MARK: - Variables

    @IBOutlet weak var pubsColletion: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!

    var managerPosizione: CLLocationManager!
    var posizioneUtente: CLLocationCoordinate2D!
    var pointAnnotation: MKPointAnnotation!
    var pinAnnotationView: MKPinAnnotationView!
    let googleKey = "AIzaSyDcebxs3npP0RzShXKikck-pBlrR5m5AZg"
    let radius = 5000 //in meters
    var url: String!
    var swiftyJSONVar: JSON?
    var pubsCout: Int?

    // MARK: - Default

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pubsColletion.delegate = self
        pubsColletion.dataSource = self
        self.mapView.delegate = self
        self.managerPosizione = CLLocationManager()
        managerPosizione.delegate = self
        managerPosizione.desiredAccuracy = kCLLocationAccuracyHundredMeters
        managerPosizione.requestWhenInUseAuthorization()
        managerPosizione.startUpdatingLocation()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Functions

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.posizioneUtente = userLocation.coordinate
        let lat = userLocation.coordinate.latitude
        let long = userLocation.coordinate.longitude
        // print("posizione aggiornata - lat: \(lat) long: \(long)")
        if(swiftyJSONVar == nil) { downloadJSON(latitude: String(lat), longitude: String(long)) }
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: posizioneUtente, span: span)
        mapView.setRegion(region, animated: true)
        if(swiftyJSONVar != JSON.null) {
            if(swiftyJSONVar?["results"].count != 0) {
                pubsColletion.reloadData()
            }
        }
    }

    func downloadJSON(latitude: String, longitude: String) {
        self.url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&keyword=pub&rankby=prominence&radius=\(radius)&type=bar&key=\(googleKey)"
        print(self.url)
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                self.swiftyJSONVar = JSON(response.result.value!)
                print(self.swiftyJSONVar!)
                return
            case .failure:
                print("Errore")
                return
            }
        }
    }

}

// MARK: - Collection View
    extension PubsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if(swiftyJSONVar != nil) { return swiftyJSONVar!["results"].count }
            else { return 0 }
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pubCell", for: indexPath) as! PubCollectionViewCell
            if(swiftyJSONVar != nil) {
                if(cell.pubImage?.image == nil) {
                    let photoReference = swiftyJSONVar!["results"][indexPath.row]["photos"][0]["photo_reference"].stringValue
                    let photoUrl = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoReference)&key=\(googleKey)"
                    cell.pubImage?.loadImageUsingCache(withUrl: photoUrl)
                }
                // cell.starRatings.settings.fillMode = .precise
                // cell.starRatings.rating = swiftyJSONVar!["results"][indexPath.row]["rating"].doubleValue
                cell.titleLabel.text = swiftyJSONVar!["results"][indexPath.row]["name"].stringValue
                if(swiftyJSONVar!["results"][indexPath.row]["opening_hours"]["open_now"].boolValue) {
                    cell.distanceLabel.text = "Aperto Ora"
                    // cell.distanceLabel.textColor
                } else {
                    cell.distanceLabel.text = "Chiuso"
                    // cell.distanceLabel.textColor =
                }
                cell.layer.shadowColor = UIColor.lightGray.cgColor
                cell.layer.shadowOffset = CGSize(width:0,height: 0)
                cell.layer.shadowRadius = 6.0
                cell.layer.shadowOpacity = 0.6
                cell.layer.masksToBounds = false;
                cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
            }
            return cell

        }
    }

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }

        }).resume()
    }
}

