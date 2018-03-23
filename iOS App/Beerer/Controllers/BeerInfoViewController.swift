//
//  BeerInfoViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 13/03/2018.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import Hero
import Alamofire
import SwiftyJSON

class BeerInfoViewController: UIViewController {

    // MARK: - Variables

    @IBOutlet var beerImage: UIImageView?
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerVariety: UILabel!
    @IBOutlet weak var beerTemp: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerMatch: UILabel!
    @IBOutlet weak var beerPubsLabel: UIButton!
    var passedBeer: Beer!
    var url: String!
    let googleKey = "AIzaSyDT9VTFyh8hW6YzcHtiejByvnlUJNmZ210"

    // MARK: - IBAction

    @IBAction func beerPub(_ sender: UIButton) {
        self.url = "https://maps.googleapis.com/maps/api/geocode/json?address=\(passedBeer.beerPubs[0].pubName.replacingOccurrences(of: " ", with: ""))+\(passedBeer.beerPubs[0].pubCity.replacingOccurrences(of: " ", with: ""))&key=\(googleKey)"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                let swiftyJsonVar = JSON(response.result.value!)
                if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                    let lat = swiftyJsonVar["results"][0]["geometry"]["location"]["lat"].stringValue
                    let lon = swiftyJsonVar["results"][0]["geometry"]["location"]["lng"].stringValue
                    UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=&daddr=\(lat),\(lon)&directionsmode=driving")!, options: [:], completionHandler: nil)
                }
                else {
                    print("Can't use comgooglemaps://");
                }
            case .failure:
                print("Errore")
            }
        }

    }

    @IBAction func closeButton(_ sender: UIButton) {
        self.hero.dismissViewController()
    }

    // MARK: - View

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.isStatusBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.isStatusBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.beerImage?.image = passedBeer.beerImage
        self.beerName.text = passedBeer.beerName.uppercased()
        self.beerVariety.text = passedBeer.beerVariety
        self.beerTemp.text = String(passedBeer.beerTemp)
        self.beerDescription.text = "“" + passedBeer.beerDescription + "“"
        self.beerMatch.text = String(passedBeer.beerPercentage) + "%"
        self.beerPubsLabel.setTitle(passedBeer.beerPubs[0].pubName, for: .normal)
        self.maskImage()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func maskImage() {
        let maskImageView = UIImageView()
        maskImageView.contentMode = .scaleAspectFit
        maskImageView.image = #imageLiteral(resourceName: "Sfondo")
        maskImageView.frame = (beerImage?.bounds)!
        beerImage?.mask = maskImageView
    }

}
