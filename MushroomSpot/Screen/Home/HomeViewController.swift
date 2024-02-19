//
//  HomeViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

/** Screen for home page containing a list of mushrooms and actions to reach other pages. */
class HomeViewController: UIViewController {
    
    /** Table containing mushroom list content. */
    @IBOutlet weak var contentTable: HomeTableView!
    
    /** View model for this screen. */
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup navigation bar layout.
        updateNavigationLayout()
        // On item tap, go to details screen with data of this item.
        contentTable.onTap = { [weak self] (item) in guard let this = self else { return }
            this.navigateToDetails(item: item)
        }
        // Update content when data is loaded.
        viewModel.onLoad = { [weak self] (result) in guard let this = self else { return }
            switch result {
            case .success(let items):
                this.contentTable.values = items
                this.contentTable.reloadData()
            case .failure:
                break
            }
        }
        // Fetch data for mushroom list.
        viewModel.load()
    }
    
    /** Updates navigation bar to include title and buttons for profile and logout. */
    func updateNavigationLayout() {
        title = String(localized: "home_title")
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(
            title: String(localized: "home_logout_button_action"),
            style: .plain,
            target: self,
            action: #selector(self.onLogoutButtonTap(sender:))
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(
            title: String(localized: "home_profile_button_action"),
            style: .plain,
            target: self,
            action: #selector(self.onProfileButtonTap(sender:))
        )
    }
    
    /** Navigates to details screen with provided item. */
    func navigateToDetails(item: MushroomEntity) {
        let controller = createViewController(of: DetailsViewController.self)
        controller?.item = item
        navigationPushViewController(controller)
    }
    
    /** Event for clicking on logout button. This will log them out and navigate back to login screen. */
    @objc func onLogoutButtonTap(sender: Any) {
        navigationPopViewController()
    }
    
    /** Event for clicking on profile button. This will display profile screen modally. */
    @objc func onProfileButtonTap(sender: Any) {
        if let controller = createViewController(of: ProfileViewController.self) {
            controller.sheetPresentationController?.detents = [.custom { _ in 200 }]
            present(controller, animated: true)
        }
    }
    
}
