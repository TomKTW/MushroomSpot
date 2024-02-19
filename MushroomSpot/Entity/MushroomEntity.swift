//
//  MushroomEntity.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation
import UIKit

/** Entity model of mushroom. */
class MushroomEntity: NSObject {
    
    /** Identiffication value, represetented as number in string.*/
    let id: String?
    
    /** Name of the mushroom. */
    let name: String?
    
    /** Name of the mushroom in latin. */
    let latinName: String?
    
    /** Image of the mushroom. */
    let profilePicture: UIImage?
    
    init(id: String?, name: String?, latinName: String?, profilePicture: UIImage?) {
        self.id = id
        self.name = name
        self.latinName = latinName
        self.profilePicture = profilePicture
    }
    
}
