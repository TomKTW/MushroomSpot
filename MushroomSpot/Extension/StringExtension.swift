//
//  StringExtension.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation

extension String {
    
    func orEmpty() {
        return
    }
    
    /** Returns dictionary object decoded from string itself representing JSON object. If the string doesn't represent an JSON object, nil is returned instead. */
    func toJsonObjectAsDictionary() -> [String : Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data(using: .utf8)!, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription); return nil
        }
    }
    
}

extension Optional where Wrapped == String {
    
    /** Returns empty string if wrapped value is nil, otherwise wrapped value is used. */
    public func orEmpty() -> String {
        return self ?? ""
    }
    
}
