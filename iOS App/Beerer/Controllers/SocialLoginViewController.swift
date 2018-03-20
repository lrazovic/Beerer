//
//  SocialLoginViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 17/03/18.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import Auth0


class SocialLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func socialLogin(_ sender: UIButton) {
        self.showLogin()
    }
    fileprivate func showLogin() {
        Auth0
            .webAuth()
            .audience("https://beerer.eu.auth0.com/userinfo")
            .scope("openid profile offline_access")
            .start {
                switch $0 {
                case .failure(let error):
                    print("Error: \(error)")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "pageViewController") as! WalkViewController
                    self.present(newViewController, animated: true, completion: nil)
                case .success(let credentials):
                    print(credentials.accessToken!)
                    if(!SessionManager.shared.store(credentials: credentials)) {
                        print("Failed to store credentials")
                        self.showLogin()
                    } else {
                        print("Tutto Ok!")
                        // self.performSegue(withIdentifier: "toSetup", sender: self)
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "setupViewController") as! ViewController
                        self.present(newViewController, animated: true, completion: nil)
                    }
                }
        }
    }

}
