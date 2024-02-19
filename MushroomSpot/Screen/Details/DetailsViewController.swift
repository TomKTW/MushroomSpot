//
//  DetailsViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

/** Screen for details of provided mushroom item. */
class DetailsViewController: UIViewController {
    
    /** Table containing mushroom item content. */
    @IBOutlet weak var contentTable: DetailsTableView!

    /** Mushroom item used for displaying content. */
    var item: MushroomEntity? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup navigation bar layout.
        updateNavigationLayout()
        // Apply item to table and reload it.
        contentTable.item = item
        contentTable.reloadData()
    }
    
    /** Updates navigation bar to include title. */
    func updateNavigationLayout() {
        title = String(localized: "details_title")
    }
    
    /** Event for clicking on back button. This will navigate back to previous screen. */
    @IBAction func onBackButtonTap(_ sender: Any) {
        navigateBack()
    }
    
    /** Navigates back to previous screen. */
    private func navigateBack() {
        navigationPopViewController()
    }
    
}
