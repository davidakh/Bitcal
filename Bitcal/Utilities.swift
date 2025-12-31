//
//  Utilities.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/22/25.
//

import Foundation

enum StoredBase: String {
    case binary
    case decimal
    case hexadecimal

    var toNumberBase: NumberBase {
        switch self {
        case .binary: return .binary
        case .decimal: return .decimal
        case .hexadecimal: return .hexadecimal
        }
    }
}

func loadDefaultNumberBase() -> NumberBase {
    let saved = UserDefaults.standard.string(forKey: "defaultNumberSystem") ?? "decimal"
    return StoredBase(rawValue: saved)?.toNumberBase ?? .decimal
}

