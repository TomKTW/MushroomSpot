//
//  HomeViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

/** Screen for home page containing a list of mushrooms and actions to reach other pages. */
class HomeViewController: UIViewController {
    
    /** Toolbar with actions on header. */
    @IBOutlet weak var headerToolbar: UIToolbar!
    
    /** Table containing mushroom list content. */
    @IBOutlet weak var contentTable: HomeTableView!
    
    /** View model for this screen. */
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    /** Navigates to details screen with provided item. */
    func navigateToDetails(item: MushroomEntity) {
        let controller = createViewController(of: DetailsViewController.self)
        controller?.item = item
        navigationPushViewController(controller)
    }
    
    /** Event for clicking on profile button. This will display profile screen modally. */
    @IBAction func onProfileButtonTap(_ sender: Any) {
        if let controller = createViewController(of: ProfileViewController.self) {
            controller.sheetPresentationController?.detents = [.custom { _ in 200 }]
            present(controller, animated: true)
        }
    }
}
