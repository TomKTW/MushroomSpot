//
//  DetailsTableView.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

class DetailsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    override init(frame: CGRect, style: UITableView.Style) { super.init(frame: frame, style: style); initialize() }

    required init?(coder: NSCoder) { super.init(coder: coder); initialize() }
        
    let itemCellIdentifier = "DetailsTableCellItemView"
    
    var onTap: ((MushroomEntity) -> Void)? = nil
    
    var item: MushroomEntity? = nil
    
    func initialize() {
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
        cell.titleLabel.text = item?.name ?? "-"
        cell.subtitleLabel.text = item?.latinName ?? "-"
        cell.iconImage.image = item?.profilePicture
        return cell
    }
    
    private func dequeueItemCell(tableView: UITableView, for indexPath: IndexPath) -> DetailsTableCellItemView? {
        return tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as? DetailsTableCellItemView
    }

}
