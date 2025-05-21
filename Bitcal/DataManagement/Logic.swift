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
}
