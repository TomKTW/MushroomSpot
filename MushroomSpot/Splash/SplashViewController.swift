//
//  SplashViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 18.02.2024..
//

import UIKit

/** Screen used on app launch to perform initial logic for navigating the user to proper screen. */
class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    /** Performs initial logic to load needed data for performing further navigation. */
    func load() {
        // Note: Current implementation is to just navigate to login screen for now.
        navigateToLogin()
    }
    
    /** Navigates to login screen for authentication. */
    func navigateToLogin() {
        navigationPushViewController(createViewController(of: LoginViewController.self))
    }
    
}
