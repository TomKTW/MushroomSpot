//
//  LoginSubmitResult.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation

/** Enumeration of results for submitting data for authorization. */
enum LoginSubmitResult {
    /** Authorization has been successful. */
    case success(authToken: String)
    /** Authorization has been unsuccessful. */
    case failure(reason: LoginSubmitFailureReason)
}
