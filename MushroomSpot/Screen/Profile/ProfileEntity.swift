//
//  ProfileEntity.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation

class ProfileEntity: NSObject {
    
    let id: String?
    let username: String?
    let firstName: String?
    let lastName: String?
    
    init(id: String?, username: String?, firstName: String?, lastName: String?) {
        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        if let first = firstName, let last = lastName {
            first + " " + last
        } else if let first = firstName {
            first
        } else if let last = lastName {
            last
        } else {
            ""
        }
    }
    
}
