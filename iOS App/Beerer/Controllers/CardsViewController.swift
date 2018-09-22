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

    let beerImages1: [UIImage]! = [#imageLiteral(resourceName: "De-Molen-good_bad_ugly.jpg"),#imageLiteral(resourceName: "Edge-Bras-KNuckles.jpg"),#imageLiteral(resourceName: "Guineu-Winter-Ale-6.8_-Bottle-330ml.jpg"),#imageLiteral(resourceName: "Kees-Wee-Heavy-Scotch-Ale-8.5_-330ml_brown.jpg"),#imageLiteral(resourceName: "Laugar – Txo Brown Ale.jpg")]
    let beerImages2: [UIImage]! = [#imageLiteral(resourceName: "ipa1.jpg"),#imageLiteral(resourceName: "ipa2.jpg"),#imageLiteral(resourceName: "ipa3.jpg"),#imageLiteral(resourceName: "ipa4.jpg"),#imageLiteral(resourceName: "ipa5.jpg"),#imageLiteral(resourceName: "ipa6.jpg")]
    let beerNames1 = ["De Molen x Kees", "Edge – Brass", "Guineu – Winter", "Kees – Wee Heavy", "Laugar – Txo", "Oedipus"]
    let beerNames2 = ["Browar Rockmill", "Juicy Delight", "Laugar", "Naparbier x La Quince", "Rascals – Wunderbar", "Rascals – Swankee"]
    let beerVariery1 = ["Brown", "Brown", "Brown", "Brown", "Brown", "Brown"]
    let beerVariery2 = ["Blonde", "Blonde", "Blonde", "Blonde", "Blonde", "Blonde"]
    let beerDescription1 = ["Netherland brown ale features a nutty malt flavor with a caramel aroma.",
        "Brace yourself for a big flavourful wallop. Artfully crafted in collaboration with Longr, this beer delivers a seriously flavour that will have you coming back for more",
        "Guineu, the name of this Barcelona brand, means fox in Catalan. Here they’ve created a shrewd Winter Ale, which is a dark coloured, full bodied beer.",
        "Wee Heavy stands for Scotch Ale and in particular for the extra heavy Scotch Ale. Specially brewed for you for the cold and chilly winter months.",
        "TXO! is an English Brown Ale from the Biscayan brewer Laugar. With moderate ABV, it is an easy but gentle beer with a some of maltiness.",
        "Also known as extra special bitters, English pale ales have a strong hop flavor that is balanced by sweet malt"]
    let beerDescription2 = ["English brown ale features a nutty malt flavor with a caramel aroma.",
        "Brewed with Hops Citra, Mosaic and Chinook, this beer is your regular heavily hopped fruit bomb.",
        "Spain’s Laugar love to brew powerful and innovative beers, envisioning craft beer as a world where imagination has no limits.",
        "Collaboration between La Quince and Naparbier. Brewed using 10 hops.",
        "Wunderbar is Rascals’ wonderful experimental German IPA brewed with new breed German hops, Mandarina Bavaria and Hallertau Blanc.",
        "American IPA meets Belgian Witbier. Swankee is a hybrid of the two styles, hopped like an American IPA with the malt bill of a wheat beer and fermented with Belgian Wit yeast."]
    let beerTemp1 = [8.9, 9.2, 6.8, 8.5, 4.5, 6]
    let beerTemp2 = [6.5, 6.5, 4, 6.5, 4, 6]
    let beerPercentage1 = [78, 80, 91, 77, 64, 79]
    let beerPercentage2 = [79, 64, 77, 91, 80, 78]
    let pub1 = Pub(name: "Luppolo12", city: "Roma")
    let pub2 = Pub(name: "Trinity College Pub", city: "Roma")
    let pub3 = Pub(name: "Finnegan Irish Pub", city: "Roma")
    let pub4 = Pub(name: "A Mi Me Gusta", city: "Civitavecchia")
    let pub5 = Pub(name: "King Edward GastroPub", city: "Civitavecchia")
    let pub6 = Pub(name: "Trinity Pub", city: "Civitavecchia")
    var beerPubs1: [[Pub]]!
    var beerPubs2: [[Pub]]!


    // MARK: - Default
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

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
        if collectionView == self.beerCollectionOne { return beerImages1.count }
        else { return beerImages2.count }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.beerCollectionOne {
            let cellOne = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell1", for: indexPath) as! CollectionViewCell
            cellOne.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
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
