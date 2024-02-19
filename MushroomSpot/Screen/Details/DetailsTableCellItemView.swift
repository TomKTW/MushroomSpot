//
//  DetailsTableCellItemView.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import UIKit

class DetailsTableCellItemView: UITableViewCell {

    /** Layout view of whole content. */
    @IBOutlet weak var contentLayout: UIView!
    
    /** Image for icon to be displayed. */
    @IBOutlet weak var iconImage: UIImageView!
    
    /** Label for name title. */
    @IBOutlet weak var titleNameLabel: UILabel!
    
    /** Label for name value. */
    @IBOutlet weak var valueNameLabel: UILabel!
    
    /** Label for latin name title. */
    @IBOutlet weak var titleLatinNameLabel: UILabel!
    
    /** Label for latin name value. */
    @IBOutlet weak var valueLatinNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
