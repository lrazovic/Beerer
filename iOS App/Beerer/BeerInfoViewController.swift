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
    var image: UIImage!
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        UIApplication.shared.isStatusBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        UIApplication.shared.isStatusBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        beerImage?.image = image
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
