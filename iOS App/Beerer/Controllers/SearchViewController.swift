//
//  SearchViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 01/03/2018.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import Foundation

class SearchViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return false
    }

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        //refreshControl = UIRefreshControl()
        searchController.searchBar.placeholder = "Search beers"
        searchController.searchBar.autocorrectionType = .no
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }


}
