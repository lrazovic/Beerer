//
//  CardsViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 13/03/2018.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import Hero
import Alamofire

class CardsViewController: UIViewController {

    // MARK: - Variables

    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var beerCollectionOne: UICollectionView!
    @IBOutlet weak var beerCollectionTwo: UICollectionView!

    let beerImages1: [UIImage]! = [#imageLiteral(resourceName: "8wired-GypsyFunk2-1.jpg"), #imageLiteral(resourceName: "Siren-Sheltered-Spirit-BA-Imperial-Porter-14_-330ml.jpg"), #imageLiteral(resourceName: "Partizan-Smoking-Jacket-Tobacco-Porter-5.1_-Bottle-330ml.jpg"), #imageLiteral(resourceName: "Cold_Spark_Bottle_Mock.jpg"), #imageLiteral(resourceName: "Laugar-Braskadi-Cacao-And-Raisin-Imperial-Stout-10.5_-Bottle-330ml.jpg"), #imageLiteral(resourceName: "Siren-Sheltered-Spirit-BA-Imperial-Porter-14_-330ml.jpg")]
    let beerImages2: [UIImage]! = [#imageLiteral(resourceName: "8wired-GypsyFunk2-1.jpg"), #imageLiteral(resourceName: "Siren-Sheltered-Spirit-BA-Imperial-Porter-14_-330ml.jpg"), #imageLiteral(resourceName: "Partizan-Smoking-Jacket-Tobacco-Porter-5.1_-Bottle-330ml.jpg"), #imageLiteral(resourceName: "Cold_Spark_Bottle_Mock.jpg"), #imageLiteral(resourceName: "Laugar-Braskadi-Cacao-And-Raisin-Imperial-Stout-10.5_-Bottle-330ml.jpg"), #imageLiteral(resourceName: "Siren-Sheltered-Spirit-BA-Imperial-Porter-14_-330ml.jpg")]
    let beerNames1 = ["Gipsy Funk", "Sheltered Spirit", "Partizan", "Cold Spark", "Bras", "Peroni"]
    let beerNames2 = ["Gipsy Funk", "Sheltered Spirit", "Partizan", "Cold Spark", "Bras", "Peroni"]
    let beerVariery1 = ["Brown", "Brown", "Brown", "Brown", "Brown", "Brown"]
    let beerVariery2 = ["Blonde", "Blonde", "Blonde", "Blonde", "Blonde", "Blonde"]
    let beerDescription1 = ["English brown ale features a nutty malt flavor with a caramel aroma.",
        "English bitters are named for the bitter flavor that the hops present. They have fruity flavors and lower alcohol content.",
        "Also known as extra special bitters, English pale ales have a strong hop flavor that is balanced by sweet malt",
        "English brown ale features a nutty malt flavor with a caramel aroma.",
        "English bitters are named for the bitter flavor that the hops present. They have fruity flavors and lower alcohol content.",
        "Also known as extra special bitters, English pale ales have a strong hop flavor that is balanced by sweet malt"]
    let beerDescription2 = ["English brown ale features a nutty malt flavor with a caramel aroma.",
        "English bitters are named for the bitter flavor that the hops present. They have fruity flavors and lower alcohol content.",
        "Also known as extra special bitters, English pale ales have a strong hop flavor that is balanced by sweet malt",
        "English brown ale features a nutty malt flavor with a caramel aroma.",
        "English bitters are named for the bitter flavor that the hops present. They have fruity flavors and lower alcohol content.",
        "Also known as extra special bitters, English pale ales have a strong hop flavor that is balanced by sweet malt"]
    let beerTemp1 = [4, 5, 4.5, 6, 2, 6]
    let beerTemp2 = [3, 5, 4.5, 6.5, 4, 6]
    let beerPercentage1 = [78, 80, 91, 77, 64, 79]
    let beerPercentage2 = [79, 64, 77, 91, 80, 78]
    let pub1 = Pub(name: "Black Hole", city: "Civitavecchia")
    let pub2 = Pub(name: "Recycle", city: "Civitavecchia")
    let pub3 = Pub(name: "Pin Up", city: "Civitavecchia")
    let pub4 = Pub(name: "A Mi Me Gusta", city: "Civitavecchia")
    let pub5 = Pub(name: "King Edward GastroPub", city: "Civitavecchia")
    let pub6 = Pub(name: "Trinity Pub", city: "Civitavecchia")
    var beerPubs1: [[Pub]]!
    var beerPubs2: [[Pub]]!


    // MARK: - Default

    override func viewDidLoad() {
        super.viewDidLoad()
        beerPubs1 = [[pub1, pub2], [pub2], [pub3], [pub4], [pub5], [pub6]]
        beerPubs2 = [[pub1, pub3], [pub2], [pub3], [pub4], [pub5], [pub6]]
        beerCollectionOne.delegate = self
        beerCollectionOne.dataSource = self
        beerCollectionTwo.delegate = self
        beerCollectionTwo.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToInfo" {
            let toViewController = segue.destination as! BeerInfoViewController
            // toViewController.hidesBottomBarWhenPushed = true
            // toViewController.hero.modalAnimationType = .zoom
            // toViewController.beerImage?.inputView?.hero.modifiers = [.useNoSnapshot, .translate(y: -200), .fade]
            toViewController.passedBeer = sender as! Beer
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Functions

    // let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "beerInfo") as! BeerInfoViewController
    // self.present(secondViewController, animated: true, completion: nil)
}

// MARK: - Extensions


extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerImages1.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.beerCollectionOne {
            let cellOne = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell1", for: indexPath) as! CollectionViewCell
            cellOne.contentView.layer.cornerRadius = 14
            cellOne.contentView.layer.masksToBounds = true
            cellOne.imageView1.image = beerImages1[indexPath.row]
            cellOne.layer.shadowColor = UIColor.lightGray.cgColor
            cellOne.layer.shadowOffset = CGSize(width:0,height: 2.0)
            cellOne.layer.shadowRadius = 6.0
            cellOne.layer.shadowOpacity = 0.6
            cellOne.layer.masksToBounds = false;
            cellOne.layer.shadowPath = UIBezierPath(roundedRect:cellOne.bounds, cornerRadius:cellOne.contentView.layer.cornerRadius).cgPath
            return cellOne
        } else {
            let cellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell2", for: indexPath) as! CollectionViewCell
            cellTwo.contentView.layer.cornerRadius = 14
            cellTwo.contentView.layer.masksToBounds = true
            cellTwo.imageView2.image = beerImages2[indexPath.row]
            cellTwo.layer.shadowColor = UIColor.lightGray.cgColor
            cellTwo.layer.shadowOffset = CGSize(width:0,height: 2.0)
            cellTwo.layer.shadowRadius = 6.0
            cellTwo.layer.shadowOpacity = 0.6
            cellTwo.layer.masksToBounds = false;
            cellTwo.layer.shadowPath = UIBezierPath(roundedRect:cellTwo.bounds, cornerRadius:cellTwo.contentView.layer.cornerRadius).cgPath
            return cellTwo
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.beerCollectionOne {
            let selectedBeer: Beer = Beer(name: beerNames1[indexPath.row], variety: beerVariery1[indexPath.row], description: beerDescription1[indexPath.row], temp: beerTemp1[indexPath.row], percentage: beerPercentage1[indexPath.row], image: beerImages1[indexPath.row], pubs: beerPubs1[indexPath.row])
            performSegue(withIdentifier: "homeToInfo", sender: selectedBeer)
        } else {
            let selectedBeer: Beer = Beer(name: beerNames2[indexPath.row], variety: beerVariery2[indexPath.row], description: beerDescription2[indexPath.row], temp: beerTemp2[indexPath.row], percentage: beerPercentage2[indexPath.row], image: beerImages2[indexPath.row], pubs: beerPubs2[indexPath.row])
            performSegue(withIdentifier: "homeToInfo", sender: selectedBeer)
        }
    }
}
