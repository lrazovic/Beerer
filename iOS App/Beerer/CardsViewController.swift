//
//  CardsViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 13/03/2018.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet var beerOne: UIImageView!

    @IBOutlet var imgTap: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerOne.addGestureRecognizer(imgTap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func imgTap(_ sender: UITapGestureRecognizer) {
        print("pressed")
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "beerInfo") as! BeerInfoViewController
        self.navigationController!.pushViewController(secondViewController, animated: true)
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
