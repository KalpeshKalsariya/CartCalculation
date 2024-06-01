//
//  AppExtension.swift
//  CartCalculation
//
//  Created by  Kalpesh on 01/06/24.
//

import Foundation

extension Float {
    func roundAllAmount() -> Float {
        let stringValue = "\(self)"
        let components = stringValue.split(separator: ".")
        var formattedRoundedValue: Float = 0.0
        
        if components.count == 2 {
            let integerPart = components[0]
            let fractionalPart = components[1]
            
            if fractionalPart.count >= 4 {
                let firstFourCharacters = String(fractionalPart.prefix(4))
                
                let lastTwoCharacters = String(firstFourCharacters.suffix(2))
                
                if let checkLastTwoCharacters = Int(lastTwoCharacters), checkLastTwoCharacters > 50 {
                    let originalValue = Double("\(integerPart).\(firstFourCharacters.prefix(2))") ?? 0.0
                    let roundedValue = originalValue + 0.01
                    formattedRoundedValue = Float(String(format: "%.2f", roundedValue)) ?? 0
                } else {
                    let originalValue = Float("\(integerPart).\(firstFourCharacters.prefix(2))") ?? 0.0
                    formattedRoundedValue = Float(String(format: "%.2f", originalValue)) ?? 0
                }
            }
            else if fractionalPart.count >= 3 {
                let firstThreeCharacters = String(fractionalPart.prefix(3))
                
                let lastTwoCharacters = String(firstThreeCharacters.suffix(2))
                
                if let checkLastTwoCharacters = Int(lastTwoCharacters), checkLastTwoCharacters > 50 {
                    let originalValue = Double("\(integerPart).\(firstThreeCharacters.prefix(2))") ?? 0.0
                    let roundedValue = originalValue + 0.01
                    formattedRoundedValue = Float(String(format: "%.2f", roundedValue)) ?? 0
                } else {
                    let originalValue = Float("\(integerPart).\(firstThreeCharacters.prefix(2))") ?? 0.0
                    formattedRoundedValue = Float(String(format: "%.2f", originalValue)) ?? 0
                }
            }
            else {
                formattedRoundedValue = self
            }
            return formattedRoundedValue
        } else {
            formattedRoundedValue = self
        }
        return 0.0
    }
    
    func roundAllAmountKK() -> Float {
        // Multiplies the float by 100, rounds to the nearest integer, then divides by 100
        return (self * 100).rounded() / 100
    }
}
