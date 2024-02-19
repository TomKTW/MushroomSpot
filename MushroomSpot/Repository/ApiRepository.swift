//
//  ApiRepository.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation
import Alamofire

class ApiRepository {
    
    let baseUrl = "https://demo5845085.mockable.io/"
    
    func submitLogin(email: String, password: String, callback: @escaping (LoginSubmitResult) -> ()) {
        AF.request(baseUrl + "api/v1/users/login", method: .post, parameters: [
            "email":email,
            "password":password
        ]).responseString { response in
            let result: LoginSubmitResult = switch (response.result) {
            case .success(let responseString):
                if let dictionary = responseString.toJsonObjectAsDictionary(),
                   let data = dictionary["auth_token"] as? String {
                    .success(authToken: data)
                } else {
                    .failure(reason: .network)
                }
            case .failure(_):
                    .failure(reason: .network)
            }
            DispatchQueue.main.async { callback(result) }
        }
    }
    
    func fetchMushrooms(callback: @escaping (MushroomFetchResult) -> ()) {
        AF.request(baseUrl + "api/v1/mushrooms", method: .get).responseString { response in
            let result: MushroomFetchResult = switch (response.result) {
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
            DispatchQueue.main.async { callback(result) }
        }        
    }
    
    func fetchProfile(callback: @escaping (ProfileFetchResult) -> ()) {
        AF.request(baseUrl + "/users/me", method: .get).responseString { response in
            let result: ProfileFetchResult = switch (response.result) {
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
            case .failure(_): .failure
            }
            DispatchQueue.main.async { callback(result) }
        }
    }
    
}
