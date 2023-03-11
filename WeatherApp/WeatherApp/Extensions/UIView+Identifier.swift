//
//  UIView+Identifier.swift
//  WeatherApp
//
//  Created by Omar Hassanein on 11/03/2023.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - hide keyboard when tap outside search
    func hideKeyboard() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
}
