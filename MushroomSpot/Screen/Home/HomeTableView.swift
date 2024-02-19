//
//  HomeTableView.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

/** Table view representing a list of mushrooms content on home screen. */
class HomeTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    override init(frame: CGRect, style: UITableView.Style) { super.init(frame: frame, style: style); initialize() }

    required init?(coder: NSCoder) { super.init(coder: coder); initialize() }
    
    /** Identifier used for item cell. */
    private let itemCellIdentifier = "HomeTableCellItemView"
    
    /** Callback closure for tapping on item cell. */
    var onTap: ((MushroomEntity) -> Void)? = nil
    
    /** List of mushroom entity values. */
    var values: [MushroomEntity] = []
    
    /** Initialization method for applying delegate, data source and registering item cell view. */
    private func initialize() {
        delegate = self
        dataSource = self
        register(UINib(nibName: itemCellIdentifier, bundle: nil), forCellReuseIdentifier: itemCellIdentifier)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueItemCell(tableView: tableView, for: indexPath) else { return UITableViewCell() }
        let item = values[indexPath.item]
        cell.contentLayout.setOnTap(to: self) { this in this.onTap?(item) }
        cell.titleLabel.text = item.name ?? "-"
        cell.iconImage.image = item.profilePicture
        return cell
    }
    
    /** Returns dequeued item cell view for given table view and index path. */
    private func dequeueItemCell(tableView: UITableView, for indexPath: IndexPath) -> HomeTableCellItemView? {
        return tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as? HomeTableCellItemView
    }

}
