//
//  TabViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 19/03/18.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import Auth0

class TabViewController: UITabBarController {

    var profile: UserInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        if(!SessionManager.shared.credentialsManager.hasValid()) {
            print("Entrato")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "pageViewController")
            self.present(newViewController, animated: false, completion: nil)
        }
    }

}


