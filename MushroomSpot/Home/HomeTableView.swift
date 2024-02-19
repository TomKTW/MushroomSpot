//
//  HomeTableView.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

class HomeTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    override init(frame: CGRect, style: UITableView.Style) { super.init(frame: frame, style: style); initialize() }

    required init?(coder: NSCoder) { super.init(coder: coder); initialize() }
        
    let itemCellIdentifier = "HomeTableCellItemView"
    
    var values: [MushroomEntity] = [
        MushroomEntity(id: "1", name: "Test 1", latinName: "Test A", profilePicture: UIImage.logo),
        MushroomEntity(id: "2", name: "Test 2", latinName: "Test B", profilePicture: UIImage.logo),
        MushroomEntity(id: "3", name: "Test 3", latinName: "Test C", profilePicture: UIImage.logo)
    ]
    
    func initialize() {
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
        cell.titleLabel.text = (item.name ?? "-") + "\n" + (item.latinName ?? "-")
        cell.iconImage.image = item.profilePicture
        return cell
    }
    
    private func dequeueItemCell(tableView: UITableView, for indexPath: IndexPath) -> HomeTableCellItemView? {
        return tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as? HomeTableCellItemView
    }

}

class MushroomEntity: NSObject {
    
    let id: String?
    let name: String?
    let latinName: String?
    let profilePicture: UIImage?
    
    init(id: String?, name: String?, latinName: String?, profilePicture: UIImage?) {
        self.id = id
        self.name = name
        self.latinName = latinName
        self.profilePicture = profilePicture
    }
    
}
