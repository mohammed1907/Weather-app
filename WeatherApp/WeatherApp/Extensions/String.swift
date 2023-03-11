//
//  String.swift
//  WeatherApp
//
//  Created by Omar Hassanein on 11/03/2023.
//

import Foundation
extension String {
    func getTime() -> String {
         let time = Date()
         let timeFormatter = DateFormatter()
         timeFormatter.dateFormat = "dd.MM.yyyy - HH:mm a"
         timeFormatter.locale = Locale(identifier: "en")
         let stringDate = timeFormatter.string(from: time)
         return stringDate
        }
}
