//
//  UIView+Identifier.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
        layer.shadowColor = UIColor(named:"shadowColor")?.cgColor
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
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
