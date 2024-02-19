//
//  ProfileFetchResult.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation

/** Enumeration of results for fetching profile data. */
enum ProfileFetchResult {
    /** Fetching data has been successful. */
    case success(item: ProfileEntity)
    /** Fetching data has been unsuccessful. */
    case failure
}
