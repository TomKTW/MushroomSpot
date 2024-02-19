//
//  SplashViewModel.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation
import UIKit

/** View model for splash screen. */
class SplashViewModel: NSObject {
    
    /** Instance of setting repository. */
    var settingRepository: SettingRepository { (UIApplication.shared.delegate as! AppDelegate).settingRepository }
    
    func isLoggedIn() -> Bool {
        return settingRepository.authToken != nil
    }
    
}
