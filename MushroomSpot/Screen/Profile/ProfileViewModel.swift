//
//  ProfileViewModel.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation
import Alamofire
import UIKit

class ProfileViewModel: NSObject {
    
    var apiRepository: ApiRepository { (UIApplication.shared.delegate as! AppDelegate).apiRepository }
    
    var onLoad: ((ProfileFetchResult) -> Void)? = nil
    
    func load() {
        apiRepository.fetchProfile { [weak self] result in guard let this = self else { return }
            this.onLoad?(result)
        }
    }
            
}
