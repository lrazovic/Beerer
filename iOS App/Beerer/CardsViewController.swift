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
    
    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var beer1: UIImageView!
    @IBOutlet weak var beer2: UIImageView!
    @IBOutlet weak var beer3: UIImageView!
    @IBOutlet weak var beer4: UIImageView!
    @IBOutlet weak var beer5: UIImageView!
    @IBOutlet weak var beer6: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(tapGestureFunc))
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     @objc func tapGestureFunc(gestureRecognizer: UITapGestureRecognizer) {
        //print(gestureRecognizer.description)
        // navigationController?.hero.navigationAnimationType = .cover(direction: .up)
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "beerInfo") as! BeerInfoViewController
        let beerImageView = gestureRecognizer.view as! UIImageView
        let beerImage = beerImageView.image

        secondViewController.beerImage?.image = beerImage
        self.present(secondViewController, animated: true, completion: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
