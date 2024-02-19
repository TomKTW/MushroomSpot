//
//  DetailsViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

/** Screen for details of provided mushroom item. */
class DetailsViewController: UIViewController {
    
    /** Toolbar with actions on header. */
    @IBOutlet weak var headerToolbar: UIToolbar!
    
    /** Table containing mushroom item content. */
    @IBOutlet weak var contentTable: DetailsTableView!

    /** Mushroom item used for displaying content. */
    var item: MushroomEntity? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Apply item to table and reload it.
        contentTable.item = item
        contentTable.reloadData()
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
