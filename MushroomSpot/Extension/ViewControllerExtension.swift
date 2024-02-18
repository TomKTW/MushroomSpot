//
//  ViewController.swift
//  MushroomSpot
//
//  Created by Tom.K on 18.02.2024..
//

import Foundation
import UIKit

extension UIViewController {
            
    /** Returns an initialized storyboard from provided name. */
    func storyboard(from name: String) -> UIStoryboard {
        return UIStoryboard.init(name: name, bundle: nil)
    }
    
    /** Returns a new instance of view controller from provided storyboard name and view controller identifier. */
    func createViewController(from name: String, with identifier: String? = nil) -> UIViewController? {
        if let identifier = identifier {
            return storyboard(from: name).instantiateViewController(withIdentifier: identifier)
        } else {
            return storyboard(from: name).instantiateInitialViewController()
        }
    }
    
    /**
     Returns a new instance of view controller with provided class type and view controller identifier.
     Note that the name of class type must match the name of storyboard target that also contains a view controller matching the class type.
     */
    func createViewController<T: UIViewController>(of type: T.Type, identifier: String? = nil) -> T? {
        return createViewController(from: String(describing: type.self), with: identifier) as? T
    }
    
    /** Push provided view controller to navigation stack. */
    func navigationPushViewController(_ controller: UIViewController?, animated: Bool = true) {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: animated)
        }
    }
    
    /** Pop view controller from navigation stack. */
    func navigationPopViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
}
