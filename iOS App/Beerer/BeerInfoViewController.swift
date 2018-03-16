//
//  BeerInfoViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 13/03/2018.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import Hero

class BeerInfoViewController: UIViewController {
    @IBOutlet var beerImage: UIImageView?
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerVariety: UILabel!
    @IBOutlet weak var beerTemp: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerMatch: UILabel!
    
    var passedBeer: Beer!

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.isStatusBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
        hero.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func closeButton(_ sender: UIButton) {
        navigationController?.hero.navigationAnimationType = .auto
        self.hero.unwindToRootViewController()
    }

}
