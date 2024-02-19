//
//  LoginViewModel.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation

/** View model for login screen. */
class LoginViewModel: NSObject {
    
    /** Callback closure for login submission. */
    var onSubmit: ((LoginSubmitResult) -> Void)? = nil
    
    /** Submits data for authorization. Callback is invoked through onSubmit closure object. */
    func submit(email: String?, password: String?) {
        // Validate input field values.
        let isEmailValid = validateEmail(value: email ?? "")
        let isPasswordValid = validatePassword(value: password ?? "")
        // Make an array of all fields that are invalid.
        let invalidFields = [
            !isEmailValid ? LoginSubmitFields.email : nil,
            !isPasswordValid ? LoginSubmitFields.password : nil
        ].compactMap { $0 }
        // If there are no invalid fields, proceed with submitting data. Otherwise, respond with failed result.
        if (invalidFields.isEmpty) {
            // TODO: Add logic to submit data to backend.
            onSubmit?(.success)
        } else {
            onSubmit?(.failure(.invalidField(invalidFields)))
        }
    }
    
    /** Returns true if provided string is a valid e-mail address. */
    private func validateEmail(value: String) -> Bool {
        // Note: Validation might have some edge cases:
        // https://en.wikipedia.org/wiki/Email_address#Examples
        // https://www.netmeister.org/blog/email.html
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: value)
    }
    
    /** Returns true if provided string is a valid password. */
    private func validatePassword(value: String) -> Bool {
        // Note: Validating password on client-side can cause issues
        // since it's possible that user's password stored
        // on backend doesn't match these conditions.
        let regex = "^" // Anchor start
            + "(?=.*[0-9])" // Contains at least one number.
            + "(?=.*[a-z])" // Contains at least one lowercase letter.
            + "(?=.*[A-Z])" // Contains at least one uppercase letter.
            + "(?=.*[^A-Za-z0-9])" // Contains at least one special character (any non-alphanumeric)
            + ".{8,}" // Must have at least 8 chracters or more.
        + "$" // Anchor end
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: value)
    }
    
}
