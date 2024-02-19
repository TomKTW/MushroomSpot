//
//  DetailsTableView.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

/** Table view representing content of a mushroom item on details screen. */
class DetailsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    override init(frame: CGRect, style: UITableView.Style) { super.init(frame: frame, style: style); initialize() }

    required init?(coder: NSCoder) { super.init(coder: coder); initialize() }
    
    /** Identifier used for item cell. */
    private let itemCellIdentifier = "DetailsTableCellItemView"
    
    /** Mushroom entity item used for providing details content. */
    var item: MushroomEntity? = nil
    
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
        return item != nil ? 1 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueItemCell(tableView: tableView, for: indexPath) else { return UITableViewCell() }
        cell.titleNameLabel.text = String(localized: "details_name_title")
        cell.titleLatinNameLabel.text = String(localized: "details_latin_name_title")
        cell.valueNameLabel.text = item?.name ?? "-"
        cell.valueLatinNameLabel.text = item?.latinName ?? "-"
        cell.iconImage.image = item?.profilePicture
        return cell
    }
    
    /** Returns dequeued item cell view for given table view and index path. */
    private func dequeueItemCell(tableView: UITableView, for indexPath: IndexPath) -> DetailsTableCellItemView? {
        return tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as? DetailsTableCellItemView
    }

}
