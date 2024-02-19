//
//  ViewExtension.swift
//  MushroomSpot
//
//  Created by Tom.K on 18.02.2024..
//

import Foundation
import UIKit

extension UIView {
    
    /*
     This section contains extensions for UIView to provide simplified tap gesture logic.
     The tap action closure and gesture recognizer are stored within associated object with provided key IDs.
     
     This allows us to call 'setOnTap' to create gesture recognizer for given view (if it's not already defined),
     and apply tap action with simple closure function without using segues and adding boilerplate
     for adding gesture recognizers separately.
     
     Delegate object in this case is provided as weak reference to avoid reference cycle.
     */
    
    /** Alias for tap action. */
    fileprivate typealias OnTapAction = (() -> Void)

    /** Keys for tap action association. */
    fileprivate struct Key {
        static var tapActionId = "tapAction"
        static var tapGestureId = "tapGesture"
    }

    /** Tap action closure for view. Retained through associated object. */
    fileprivate var tapAction: OnTapAction? {
        get { return withUnsafePointer(to: &Key.tapActionId) { key in objc_getAssociatedObject(self, key) as? OnTapAction } }
        set { if let value = newValue { withUnsafePointer(to: &Key.tapActionId) { key in  objc_setAssociatedObject(self, key, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) } } }
    }

    /** Tap gesture instance for view. Retained through associated object. */
    fileprivate var tapGesture: UITapGestureRecognizer? {
        get { return withUnsafePointer(to: &Key.tapGestureId) { key in objc_getAssociatedObject(self, key) as? UITapGestureRecognizer } }
        set { if let value = newValue { withUnsafePointer(to: &Key.tapGestureId) { key in  objc_setAssociatedObject(self, key, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) } } }
    }

    /** Tap event function bound to gesture and used for calling tap action closure. */
    @objc fileprivate func handleTap(sender: UITapGestureRecognizer) {
        tapAction?()
    }

    /** Adds tap gesture recognizer with closure through delegate (self). Callback is always defined as weak delegate to prevent leaks. */
    public func setOnTap<Object: AnyObject>(to delegate: Object, callback: @escaping (Object) -> Void) {
        // Apply tap action closure.
        tapAction = { [weak delegate] in if let delegate = delegate { callback(delegate) } }
        // Initialize tap gesture if not initialized.
        if tapGesture == nil {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            addGestureRecognizer(tapGesture)
            self.tapGesture = tapGesture
        }
        // Enable interaction.
        isUserInteractionEnabled = true
    }

    /** Clears tap gesture recognizer with action closure. */
    public func clearOnTap() {
        tapAction = nil
        if let tapGesture = tapGesture { removeGestureRecognizer(tapGesture) }
        tapGesture = nil
    }
    
}
