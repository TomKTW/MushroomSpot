//
//  HomeViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headerToolbar: UIToolbar!
    @IBOutlet weak var contentTable: HomeTableView!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onLoad = { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let items):
                this.contentTable.values = items
                this.contentTable.reloadData()
            case .failure:
                break
            }
        }
        viewModel.load()
    }
    
}
