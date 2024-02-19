//
//  SettingRepository.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation

/** Repository for providing stored settings. */
class SettingRepository {
    
    /** Authorization token used for user authentication to backend. */
    var authToken: String? {
        get {
            UserDefaults.standard.string(forKey: "authToken")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "authToken")
        }
    }
    
}
