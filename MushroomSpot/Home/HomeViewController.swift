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
        contentTable.onTap = { [weak self] (item) in guard let this = self else { return }
            this.navigateToDetails(item: item)
        }
        viewModel.onLoad = { [weak self] (result) in guard let this = self else { return }
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
    
    func navigateToDetails(item: MushroomEntity) {
        let controller = createViewController(of: DetailsViewController.self)
        controller?.item = item
        navigationPushViewController(controller)
    }
    
}
