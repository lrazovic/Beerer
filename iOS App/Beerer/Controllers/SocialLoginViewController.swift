//
//  SocialLoginViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 17/03/18.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import Firebase


class SocialLoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }



    @IBAction func loginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default))

                self.present(alert, animated: true, completion: nil)
            } else {
                print("login ok")
                self.performSegue(withIdentifier: "toCards", sender: nil)
            }
        }

    }

    @IBAction func signupButton(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
            if error == nil {
                print("Account Creato")
                Auth.auth().signIn(withEmail: self.emailField.text!,
                                   password: self.passwordField.text!)
                self.performSegue(withIdentifier: "toCards", sender: (Any).self)
            } else {
                print("Errore  \(String(describing: error?.localizedDescription))")
            }
        }
    }
}
