//
//  HomeTableCellItemView.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

/** Cell viewl for mushroom item. */
class HomeTableCellItemView: UITableViewCell {

    /** Layout view of whole content. */
    @IBOutlet weak var contentLayout: UIView!

    /** Image for icon to be displayed. */
    @IBOutlet weak var iconImage: UIImageView!
    
    /** Label for title to be displayed .*/
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
