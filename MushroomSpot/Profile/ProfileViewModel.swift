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
    
    var onLoad: ((ProfileLoadResult) -> Void)? = nil
    
    func load() {
        AF.request("https://demo5845085.mockable.io/users/me", method: .get).responseString { response in
            let result: ProfileLoadResult = switch (response.result) {
            case .success(let responseString):
                if let dictionary = responseString.toJsonObjectAsDictionary(),
                   let user = dictionary["user"] as? [String : Any] {
                    .success(item: ProfileEntity(
                        id: user["id"] as? String,
                        username: user["username"] as? String,
                        firstName: user["first_name"] as? String,
                        lastName: user["last_name"] as? String
                    ))
                } else {
                    .failure
                }
            case .failure(_):
                    .failure
            }
            debugPrint("Response: \(response)")
            DispatchQueue.main.async { [weak self] in guard let this = self else { return }
                this.onLoad?(result)
            }
        }
    }
            
}
