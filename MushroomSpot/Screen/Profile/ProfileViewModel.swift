//
//  ProfileViewModel.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation
import Alamofire
import UIKit

/** View model for profile screen. */
class ProfileViewModel: NSObject {
    
    /** Instance of API repository. */
    var apiRepository: ApiRepository { (UIApplication.shared.delegate as! AppDelegate).apiRepository }
    
    /** Callback closure for load request. */
    var onLoad: ((ProfileFetchResult) -> Void)? = nil
    
    /** Fetches profile data from API repository. Callback is invoked through onLoad closure object. */
    func load() {
        apiRepository.fetchProfile { [weak self] result in guard let this = self else { return }
            this.onLoad?(result)
        }
    }
    
}
