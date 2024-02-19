//
//  ProfileViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

/** Screen for displaying user profile information. */
class ProfileViewController: UIViewController {
    
    /** Label for main title.*/
    @IBOutlet weak var titleLabel: UILabel!
    
    /** Label for name title. */
    @IBOutlet weak var titleNameLabel: UILabel!
    
    /** Label for name value. */
    @IBOutlet weak var valueNameLabel: UILabel!
    
    /** Label for email title. */
    @IBOutlet weak var titleEmailLabel: UILabel!
    
    /** Label for email value. */
    @IBOutlet weak var valueEmailLabel: UILabel!
    
    /** View model for this screen. */
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Localize label titles.
        titleLabel.text = String(localized: "profile_title")
        titleNameLabel.text = String(localized: "profile_name_title")
        titleEmailLabel.text = String(localized: "profile_email_title")
        // Update content when data is loaded.
        viewModel.onLoad = { [weak self] (result) in guard let this = self else { return }
            switch result {
            case .success(let item): this.updateContent(item)
            case .failure: break
            }
        }
        // Fetch data for user profile.
        viewModel.load()
    }
    
    private func updateContent(_ item: ProfileEntity) {
        valueNameLabel.text = item.fullName
        valueEmailLabel.text = item.username
    }
    
}
