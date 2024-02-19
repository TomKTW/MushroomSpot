//
//  DetailsViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var headerToolbar: UIToolbar!
    @IBOutlet weak var contentTable: DetailsTableView!

    var item: MushroomEntity? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTable.item = item
        contentTable.reloadData()
    }

    @IBAction func onBackButtonTap(_ sender: Any) {
        navigateBack()
    }
    
    func navigateBack() {
        navigationPopViewController()
    }
}
