//
//  ProfileEntity.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation

/** Entity model of user's profile. */
class ProfileEntity: NSObject {
    
    /** Identiffication value, represetented as number in string.*/
    let id: String?
    /** User name, represented and treated as e-mail address. */
    let username: String?
    /** User's first name. */
    let firstName: String?
    /** Users last name. */
    let lastName: String?
    
    init(id: String?, username: String?, firstName: String?, lastName: String?) {
        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
    }
    
    /** User's full name combined from first and last name. */
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
