//
//  ProfileViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 01/03/2018.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var beerCollection: UICollectionView!
    @IBOutlet weak var beerNumberText: UILabel!
    @IBOutlet weak var nameSurname: UILabel!

    let beerImages1: [UIImage]! = [#imageLiteral(resourceName: "8wired-GypsyFunk2-1.jpg"), #imageLiteral(resourceName: "Siren-Sheltered-Spirit-BA-Imperial-Porter-14_-330ml.jpg"), #imageLiteral(resourceName: "Partizan-Smoking-Jacket-Tobacco-Porter-5.1_-Bottle-330ml.jpg"), #imageLiteral(resourceName: "Cold_Spark_Bottle_Mock.jpg"), #imageLiteral(resourceName: "Laugar-Braskadi-Cacao-And-Raisin-Imperial-Stout-10.5_-Bottle-330ml.jpg"),#imageLiteral(resourceName: "ipa5.jpg"),#imageLiteral(resourceName: "ipa6.jpg"),#imageLiteral(resourceName: "Guineu-Winter-Ale-6.8_-Bottle-330ml.jpg")]
    let beerNames1 = ["Gipsy Funk", "Sheltered Spirit", "Partizan", "Cold Spark", "Bras", "Peroni","Gipsy Funk", "Sheltered Spirit", "Partizan", "Cold Spark", "Bras", "Peroni"]
    let beerVariery1 = ["Brown", "Brown", "Brown", "Brown", "Brown", "Brown","Brown", "Brown", "Brown", "Brown", "Brown", "Brown"]
    let beerDescription1 = ["English brown ale features a nutty malt flavor with a caramel aroma.",
                            "English bitters are named for the bitter flavor that the hops present. They have fruity flavors and lower alcohol content.",
                            "Also known as extra special bitters, English pale ales have a strong hop flavor that is balanced by sweet malt",
                            "English brown ale features a nutty malt flavor with a caramel aroma.",
                            "English bitters are named for the bitter flavor that the hops present. They have fruity flavors and lower alcohol content.",
                            "Also known as extra special bitters, English pale ales have a strong hop flavor that is balanced by sweet malt",
                            "English brown ale features a nutty malt flavor with a caramel aroma.",
                            "English bitters are named for the bitter flavor that the hops present. They have fruity flavors and lower alcohol content.",
                            "Also known as extra special bitters, English pale ales have a strong hop flavor that is balanced by sweet malt",
                            "English brown ale features a nutty malt flavor with a caramel aroma.",
                            "English bitters are named for the bitter flavor that the hops present. They have fruity flavors and lower alcohol content.",
                            "Also known as extra special bitters, English pale ales have a strong hop flavor that is balanced by sweet malt"]
    let beerTemp1 = [4, 5, 4.5, 6, 7.2, 6.5, 8, 5, 4.5, 6.5, 4.9, 6]
    let beerPercentage1 = [78, 80, 91, 77, 64, 79, 79, 64, 77, 91, 80, 78]
    let pub1 = Pub(name: "Luppolo12", city: "Roma")
    let pub2 = Pub(name: "Trinity College Pub", city: "Roma")
    let pub3 = Pub(name: "Finnegan Irish Pub", city: "Roma")
    let pub4 = Pub(name: "A Mi Me Gusta", city: "Civitavecchia")
    let pub5 = Pub(name: "King Edward GastroPub", city: "Civitavecchia")
    let pub6 = Pub(name: "Trinity Pub", city: "Civitavecchia")
    var beerPubs1: [[Pub]]!
    
    @IBAction func settingButton(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch (let error) {
            print("Auth sign out failed: \(error)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        beerPubs1 = [[pub1, pub2], [pub2], [pub3], [pub4], [pub5], [pub6],[pub1, pub2], [pub2], [pub3], [pub4], [pub5], [pub6]]
        beerCollection.delegate = self
        beerCollection.dataSource = self
        self.beerNumberText.text = "\(beerImages1.count) beers drank! 🍻"
    
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileToInfo" {
            let toViewController = segue.destination as! BeerInfoViewController
            // toViewController.hidesBottomBarWhenPushed = true
            // toViewController.hero.modalAnimationType = .zoom
            // toViewController.beerImage?.inputView?.hero.modifiers = [.useNoSnapshot, .translate(y: -200), .fade]
            toViewController.passedBeer = sender as! Beer
        }
    }

}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerImages1.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cellOne = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! CollectionViewCell
            cellOne.profileBeerImage.image = beerImages1[indexPath.row]
        cellOne.contentView.layer.cornerRadius = 14
        cellOne.contentView.layer.masksToBounds = true
        cellOne.layer.shadowColor = UIColor.lightGray.cgColor
        cellOne.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cellOne.layer.shadowRadius = 6.0
        cellOne.layer.shadowOpacity = 0.6
        cellOne.layer.masksToBounds = false;
        cellOne.layer.shadowPath = UIBezierPath(roundedRect:cellOne.bounds, cornerRadius:cellOne.contentView.layer.cornerRadius).cgPath
            return cellOne

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedBeer: Beer = Beer(name: beerNames1[indexPath.row], variety: beerVariery1[indexPath.row], description: beerDescription1[indexPath.row], temp: beerTemp1[indexPath.row], percentage: beerPercentage1[indexPath.row], image: beerImages1[indexPath.row], pubs: beerPubs1[indexPath.row])
            performSegue(withIdentifier: "profileToInfo", sender: selectedBeer)

    }
}
    
