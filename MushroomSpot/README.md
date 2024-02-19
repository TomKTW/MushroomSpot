#  MushroomSpot

This application provides a list of mushrooms and details about them.

## Splash

Splash screen is used as a base to perform initial checks before navigating to other screen.

If authorization token is stored, user can proceed to home screen.

## Login

Login screen is used for user authorization.

E-mail field must contain a valid e-mail address, while password field has multiple conditions:

- At least 8 characters
- At least one number
- At least one lowercase letter
- At least one uppercase letter
- At least one special character

When these conditions match, a request is sent to the server for authentication. If successful, authorization token is stored and user is navigated to home screen.

## Home

Application will initially load a list of mushrooms and display it on a list. By clicking on any mushroom item, user will be redirected to details screen.

User can also click on profile button to show user info. By clicking on logout, user is prompted before leaving the home screen.

## Details

Mushroom details are passed from previous view controller and displayed on this screen.

## Profile

This screen shows user information after it's loaded.

## Libraries

Currently, only Alamofire is used as HTTP client. Cocoapods are added in case the project requires pods that are not available from SPM in the future.
