//
//  Logic.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/20/25.
//

import Foundation

struct Logic {
    static func add(_ a: String, _ b: String) -> String {
        let aChars = Array(a.reversed())
        let bChars = Array(b.reversed())
        var carry = 0
        var result = ""

        let maxLength = max(aChars.count, bChars.count)
        for i in 0..<maxLength {
            let aBit = i < aChars.count ? Int(String(aChars[i]))! : 0
            let bBit = i < bChars.count ? Int(String(bChars[i]))! : 0
            
            let sum = aBit + bBit + carry
            result = String(sum % 2) + result
            carry = sum / 2
            }

        if carry > 0 {
            result = "1" + result
        }

        return result
    }
    
    static func subtract(_ a: String, _ b: String) -> String {
        let aBits = Array(a.reversed())
        let bBits = Array(b.reversed())
        var result = ""
        var borrow = 0
        
        let maxLength = max(aBits.count, bBits.count)
        for i in 0..<maxLength {
            let aBit = i < aBits.count ? Int(String(aBits[i]))! : 0
            let bBit = i < bBits.count ? Int(String(bBits[i]))! : 0
            
            var diff = aBit - bBit - borrow
            
            if diff < 0 {
                diff += 2
                borrow = 1
            } else {
                borrow = 0
            }
            
            result = String(diff) + result
        }
        
        let cleaned = result.drop(while: { $0 == "0" })
        return cleaned.isEmpty ? "0" : String(cleaned)
    }
    
    static func multiply(_ a: String, _ b: String) -> String {
        guard let aInt = Int(a, radix: 2), let bInt = Int(b, radix: 2) else {
            return "0"
        }
        let product = aInt * bInt
        return String(product, radix: 2)
    }

    static func divide(_ a: String, _ b: String) -> String {
        guard let aInt = Int(a, radix: 2),
              let bInt = Int(b, radix: 2),
              bInt != 0 else {
            return "Error" // Division by zero or invalid input
        }
        let quotient = aInt / bInt
        return String(quotient, radix: 2)
    }
    
    static func convert(_ input: String, fromBase: Int, toBase: Int) -> String {
        guard let intValue = Int(input, radix: fromBase) else {
            return "0"
        }
        return String(intValue, radix: toBase).uppercased()
    }
    
    static func binaryToDecimal(_ binary: String) -> String {
        return convert(binary, fromBase: 2, toBase: 10)
    }

    static func binaryToHex(_ binary: String) -> String {
        return convert(binary, fromBase: 2, toBase: 16)
    }

    static func decimalToBinary(_ decimal: String) -> String {
        return convert(decimal, fromBase: 10, toBase: 2)
    }

    static func decimalToHex(_ decimal: String) -> String {
        return convert(decimal, fromBase: 10, toBase: 16)
    }

    static func hexToBinary(_ hex: String) -> String {
        return convert(hex, fromBase: 16, toBase: 2)
    }

    static func hexToDecimal(_ hex: String) -> String {
        return convert(hex, fromBase: 16, toBase: 10)
    }
}

enum NumberBase: String, CaseIterable, Identifiable {
    case binary = "Binary"
    case decimal = "Decimal"
    case hexadecimal = "Hex"

    var id: String { self.rawValue }

    var radix: Int {
        switch self {
        case .binary: return 2
        case .decimal: return 10
        case .hexadecimal: return 16
        }
    }
}
