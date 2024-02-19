//
//  StringExtension.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation
import UIKit

extension String {
    
    func orEmpty() {
        return
    }
    
    /** Returns dictionary object decoded from string itself representing JSON object. If the string doesn't represent an JSON object, nil is returned instead. */
    func toJsonObjectAsDictionary() -> [String : Any]? {
        if let data = data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func toBase64UrlImageAsUIImage() -> UIImage? {
        if let url = URL(string: self) {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                return image
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}

extension Optional where Wrapped == String {
    
    /** Returns empty string if wrapped value is nil, otherwise wrapped value is used. */
    public func orEmpty() -> String {
        return self ?? ""
    }
    
}
