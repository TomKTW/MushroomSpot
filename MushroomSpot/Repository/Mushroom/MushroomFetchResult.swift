//
//  MushroomFetchResult.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation

/** Enumeration of results for fetching mushroom list. */
enum MushroomFetchResult {
    /** Fetching data has been successful. */
    case success(items: [MushroomEntity])
    /** Fetching data has been unsuccessful. */
    case failure
}
