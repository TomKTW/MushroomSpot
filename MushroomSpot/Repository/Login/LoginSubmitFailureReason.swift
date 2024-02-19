//
//  LoginSubmitFailureReason.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation

/** Enumeration of reasons that have caused authorization to fail. */
enum LoginSubmitFailureReason {
    /** Fields with invalid values were submitted. */
    case invalidField(fields: [LoginSubmitInputFields])
    /** Network response has failed. Used as a generic reason for backend side failures.*/
    case network
}
