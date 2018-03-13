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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func closeButton(_ sender: UIButton) {
        print("button pressed")
        navigationController?.hero.navigationAnimationType = .auto
        self.hero.unwindToRootViewController()
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
