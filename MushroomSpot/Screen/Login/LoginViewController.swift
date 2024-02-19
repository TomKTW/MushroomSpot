//
//  LoginViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 18.02.2024..
//

import UIKit

/** Screen for user authorization to access further content of this application. */
class LoginViewController: UIViewController {
    
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
    }
    
    /** Invokes event when authorization has been successful. */
    private func onSubmitSuccess(authToken: String) {
        navigateToHome()
    }
    
    /** Invokes event when authorization has been unsuccessful. */
    private func onSubmitFailure(reason: LoginSubmitFailureReason) {
        switch reason {
        case .invalidField(let fields):
            
            let emailReminder = "\n" + "\n" + String(localized: "login_submit_action_failure_message_invalid_field_email_hint")
            let passwordReminder = "\n" + "\n" + String(localized: "login_submit_action_failure_message_invalid_field_password_hint")
            let message = if (fields.contains(.email) && fields.contains(.password)) {
                String(localized: "login_submit_action_failure_message_invalid_field_email_and_password") + emailReminder + passwordReminder
            } else if (fields.contains(.email) && !fields.contains(.password)) {
                String(localized: "login_submit_action_failure_message_invalid_field_email") + emailReminder
            } else if (!fields.contains(.email) && fields.contains(.password)) {
                String(localized: "login_submit_action_failure_message_invalid_field_password") + passwordReminder
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
    
}
