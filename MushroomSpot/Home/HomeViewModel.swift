//
//  HomeViewModel.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation
import Alamofire
import UIKit

class HomeViewModel: NSObject {
    
    var onLoad: ((HomeLoadResult) -> Void)? = nil
    
    func load() {
        AF.request("https://demo5845085.mockable.io/api/v1/mushrooms", method: .get).responseString { response in
            let result: HomeLoadResult = switch (response.result) {
            case .success(let responseString):
                if let dictionary = responseString.toJsonObjectAsDictionary(),
                   let array = dictionary["mushrooms"] as? [[String : Any]] {
                    .success(items: array.map { item in
                        MushroomEntity(
                            id: item["id"] as? String,
                            name: item["name"] as? String,
                            latinName: item["latin_name"] as? String,
                            profilePicture: (item["profile_picture"] as? String)?.toBase64UrlImageAsUIImage()
                        )
                    })
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
