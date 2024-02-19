//
//  ProfileViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var valueNameLabel: UILabel!
    @IBOutlet weak var titleEmailLabel: UILabel!
    @IBOutlet weak var valueEmailLabel: UILabel!
    
    /** View model for this screen. */
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNameLabel.text = String(localized: "profile_name_title")
        titleEmailLabel.text = String(localized: "profile_email_title")
        viewModel.onLoad = { [weak self] (result) in guard let this = self else { return }
            switch result {
            case .success(let item):
                this.valueNameLabel.text = item.fullName
                this.valueEmailLabel.text = item.username
            case .failure:
                break
            }
        }
        viewModel.load()
    }

    @IBAction func onBackButtonTap(_ sender: Any) {
        navigateBack()
    }
    
    func navigateBack() {
        navigationPopViewController()
    }
    
}
