//
//  MushroomEntity.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation
import UIKit

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
