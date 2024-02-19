//
//  LoginViewModel.swift
//  MushroomSpot
//
//  Created by Tom.K on 19.02.2024..
//

import Foundation
import UIKit
import Alamofire

/** View model for login screen. */
class LoginViewModel: NSObject {
    
    /** Instance of API repository. */
    var apiRepository: ApiRepository { (UIApplication.shared.delegate as! AppDelegate).apiRepository }
    
    /** Instance of setting repository. */
    var settingRepository: SettingRepository { (UIApplication.shared.delegate as! AppDelegate).settingRepository }
    
    /** Callback closure for login submission. */
    var onSubmit: ((LoginSubmitResult) -> Void)? = nil
    
    /** Submits data for authorization. Callback is invoked through onSubmit closure object. */
    func submit(email: String, password: String) {
        // Validate input field values.
        let isEmailValid = validateEmail(value: email)
        let isPasswordValid = validatePassword(value: password)
        // Make an array of all fields that are invalid.
        let invalidFields: [LoginSubmitInputFields] = [
            !isEmailValid ? .email : nil,
            !isPasswordValid ? .password : nil
        ].compactMap { $0 }
        // If there are no invalid fields, proceed with submitting data. Otherwise, respond with failed result.
        if (invalidFields.isEmpty) {
            apiRepository.submitLogin(email: email, password: password) { [weak self] result in guard let this = self else { return }
                this.onSubmit?(result)
            }
        } else {
            onSubmit?(.failure(reason: .invalidField(fields: invalidFields)))
        }
    }
    
    /** Sets authorization token from stored settings.*/
    func setAuthToken(_ token: String?) {
        settingRepository.authToken = token
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
