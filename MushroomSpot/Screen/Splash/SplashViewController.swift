//
//  SplashViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 18.02.2024..
//

import UIKit

/** Screen used on app launch to perform initial logic for navigating the user to proper screen. */
class SplashViewController: UIViewController {
    
    private let viewModel = SplashViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Based on login state, check where user should be navigated to.
        viewModel.isLoggedIn() ? navigateToHome() : navigateToLogin()
    }
    
    /** Navigates to login screen for authentication. */
    func navigateToLogin() {
        navigationPushViewController(createViewController(of: LoginViewController.self))
    }
    
    /** Navigates to home screen. */
    func navigateToHome() {
        navigationPushViewController(createViewController(of: HomeViewController.self))
    }
    
}
