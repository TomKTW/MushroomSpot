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

/** Enumeration of reasons that have caused authorization to fail. */
enum LoginSubmitFailureReason {
    /** Fields with invalid values were submitted. */
    case invalidField(fields: [LoginSubmitFields])
    /** Network response has failed. Used as a generic reason for backend side failures.*/
    case network
}

/** Enumeration of input fields that exist for submitting data for authorization. */
enum LoginSubmitFields {
    /** E-mail address input field. */
    case email
    /** Password input field. */
    case password
}
