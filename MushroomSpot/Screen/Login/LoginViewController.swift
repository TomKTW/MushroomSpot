//
//  LoginViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 18.02.2024..
//

import UIKit

/** Screen for user authorization to access further content of this application. */
class LoginViewController: UIViewController, UITextFieldDelegate {
    
    /** Input field for e-mail address. */
    @IBOutlet weak var emailInput: UITextField!
    
    /** Input field for password. */
    @IBOutlet weak var passwordInput: UITextField!
    
    /** Button for submitting data from provided fields. */
    @IBOutlet weak var submitButton: UIButton!
    
    /** Progress for submitting data from provided fields. */
    @IBOutlet weak var submitProgress: UIActivityIndicatorView!
    
    /** View model for this screen. */
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Autofill in debug only for testing.
        #if DEBUG
        emailInput.text = "john.doe@example.com"
        passwordInput.text = "Test123!"
        #endif
        // Localize text strings.
        emailInput.placeholder = String(localized: "login_email_input_title")
        passwordInput.placeholder = String(localized: "login_password_input_title")
        // Apply input field delegates.
        emailInput.delegate = self
        passwordInput.delegate = self
        // On submit button tap, set loading state and submit the data.
        submitButton.setOnTap(to: self) { this in
            this.setSubmitRequestInProgress(enabled: true)
            this.viewModel.submit(
                email: this.emailInput.text.orEmpty(),
                password: this.passwordInput.text.orEmpty()
            )
        }
        // When results are received for submitting data, go to specific event for it and finish loading state.
        viewModel.onSubmit = { [weak self] (result) in guard let this = self else { return }
            switch result {
            case .success(let authToken): this.onSubmitSuccess(authToken: authToken)
            case .failure(let reason): this.onSubmitFailure(reason: reason)
            }
            this.setSubmitRequestInProgress(enabled: false)
        }
        
        navigationItem.hidesBackButton = true
    }
    
    /** Invokes event when authorization has been successful. */
    private func onSubmitSuccess(authToken: String) {
        viewModel.setAuthToken(authToken)
        navigateToHome()
    }
    
    /** Invokes event when authorization has been unsuccessful. */
    private func onSubmitFailure(reason: LoginSubmitFailureReason) {
        switch reason {
        case .invalidField(let fields):
            // Hints provide info to user to see what should be done before submitting.
            let emailHint = "\n" + "\n" + String(localized: "login_submit_action_failure_message_invalid_field_email_hint")
            let passwordHint = "\n" + "\n" + String(localized: "login_submit_action_failure_message_invalid_field_password_hint")
            // Based on invalid fields, pick specific message to be displayed. Empty array for invalid fields should not occur in here.
            let message = if (fields.contains(.email) && fields.contains(.password)) {
                String(localized: "login_submit_action_failure_message_invalid_field_email_and_password") + emailHint + passwordHint
            } else if (fields.contains(.email) && !fields.contains(.password)) {
                String(localized: "login_submit_action_failure_message_invalid_field_email") + emailHint
            } else if (!fields.contains(.email) && fields.contains(.password)) {
                String(localized: "login_submit_action_failure_message_invalid_field_password") + passwordHint
            } else {
                fatalError("Failure reason is invalid field, but there are no invalid fields provided in array.")
            }
            showErrorDialog(message: message)
        case .network:
            showErrorDialog(message: String(localized: "login_submit_action_failure_message_network"))
        }
    }
    
    /** Navigates to home screen. */
    private func navigateToHome() {
        navigationPushViewController(createViewController(of: HomeViewController.self))
    }
    
    /** Displays an error message. */
    private func showErrorDialog(message: String) {
        let alert = UIAlertController(title: String(localized: "login_submit_action_failure_title"), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: String(localized: "login_submit_action_failure_dismiss_action"), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    /** Sets content to loading state where interaction is disabled if set to true. Otherwise, loading state is stopped and interaction is enabled. */
    private func setSubmitRequestInProgress(enabled: Bool) {
        emailInput.isEnabled = !enabled
        passwordInput.isEnabled = !enabled
        submitButton.isUserInteractionEnabled = !enabled
        if (enabled) { submitProgress.startAnimating() } else { submitProgress.stopAnimating() }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Switch to next input on return.
        switch textField {
        case emailInput:
            passwordInput.becomeFirstResponder()
        case passwordInput:
            passwordInput.resignFirstResponder()
        default:
            break
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Mark input field with red color if validation has failed.
        switch textField {
        case emailInput: 
            let isValid = viewModel.validateEmail(value: emailInput.text.orEmpty())
            emailInput.backgroundColor = isValid ? UIColor.white : UIColor(named: "Colors/MaterialRed100")
        case passwordInput:
            let isValid =  viewModel.validatePassword(value: passwordInput.text.orEmpty())
            passwordInput.backgroundColor = isValid ? UIColor.white : UIColor(named: "Colors/MaterialRed100")
        default:
            break
        }
    }
    
}
