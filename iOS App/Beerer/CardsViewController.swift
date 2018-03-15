//
//  CardsViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 13/03/2018.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import Hero

class CardsViewController: UIViewController {

    // MARK: - Variables

    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var beerCollectionOne: UICollectionView!
    @IBOutlet weak var beerCollectionTwo: UICollectionView!
    let images1: [UIImage]! = [#imageLiteral(resourceName: "8wired-GypsyFunk2-1.jpg"),#imageLiteral(resourceName: "Siren-Sheltered-Spirit-BA-Imperial-Porter-14_-330ml.jpg"),#imageLiteral(resourceName: "Partizan-Smoking-Jacket-Tobacco-Porter-5.1_-Bottle-330ml.jpg"),#imageLiteral(resourceName: "Cold_Spark_Bottle_Mock.jpg"),#imageLiteral(resourceName: "Laugar-Braskadi-Cacao-And-Raisin-Imperial-Stout-10.5_-Bottle-330ml.jpg"),#imageLiteral(resourceName: "Siren-Sheltered-Spirit-BA-Imperial-Porter-14_-330ml.jpg")]
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))

    // MARK: - Default

    override func viewDidLoad() {
        super.viewDidLoad()
        beerCollectionOne.delegate = self
        beerCollectionOne.dataSource = self
        beerCollectionTwo.delegate = self
        beerCollectionTwo.dataSource = self
        hero.isEnabled = true
        navigationController?.hero.navigationAnimationType = .cover(direction: .up)
        tapGesture.cancelsTouchesInView = false
        beerCollectionOne.addGestureRecognizer(tapGesture)
        beerCollectionTwo.addGestureRecognizer(tapGesture)
        /*
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(tapGestureFunc))
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(tapGestureFunc))
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(tapGestureFunc))
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(tapGestureFunc))
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(tapGestureFunc))
        beer1.addGestureRecognizer(tapGesture1)
        beer2.addGestureRecognizer(tapGesture2)
        beer3.addGestureRecognizer(tapGesture3)
        beer4.addGestureRecognizer(tapGesture4)
        beer5.addGestureRecognizer(tapGesture5)
        beer6.addGestureRecognizer(tapGesture6)
        beer1.isUserInteractionEnabled = true
        beer2.isUserInteractionEnabled = true
        beer3.isUserInteractionEnabled = true
        beer4.isUserInteractionEnabled = true
        beer5.isUserInteractionEnabled = true
        beer6.isUserInteractionEnabled = true
 */

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToInfo" {
            let toViewController = segue.destination as! BeerInfoViewController
            let toBeerImage = sender as! UIImageView
            toViewController.image = toBeerImage.image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Functions

    @objc func tap(sender: UITapGestureRecognizer){

        if let indexPath = beerCollectionOne.indexPathForItem(at: sender.location(in: beerCollectionOne)) {
            let cell = beerCollectionOne.cellForItem(at: indexPath)
            print("you can do something with the cell or index path here")
        } else {
            print("collection view was tapped")
        }
    }

     @objc func tapGestureFunc(gestureRecognizer: UITapGestureRecognizer) {
        print("pressed")
        let beerImageView = gestureRecognizer.view as! UIImageView
        performSegue(withIdentifier: "homeToInfo", sender: beerImageView)
        // let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "beerInfo") as! BeerInfoViewController
        // self.present(secondViewController, animated: true, completion: nil)

    }

}

// MARK: - Extensions

extension CardsViewController: UIScrollViewDelegate {
    // Put Scroll functionalities to ViewController
    // func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //     print(scrollView)
    // }
}

extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images1.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.beerCollectionOne {
            let cellOne = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell1", for: indexPath)
            let test = cellOne.contentView
            return cellOne
        } else {
            let cellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell2", for: indexPath)
            cellTwo.isUserInteractionEnabled = true
            return cellTwo
        }
    }
}
