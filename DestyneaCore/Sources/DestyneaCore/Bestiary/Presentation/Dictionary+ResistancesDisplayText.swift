//
//  Dictionary+ResistancesDisplayText.swift
//  DestyneaCore
//
//  Created by Willy Kim on 13/11/2026.
//

public extension Dictionary where Key == DamageType, Value == Int {
    var displayText: String {
        let meaningful = filter { $0.value != 0 }
        guard !meaningful.isEmpty else { return "Aucune résistance ni faiblesse" }

        return meaningful
            .sorted { $0.key < $1.key }
            .map { type, value in
                let sign = value > 0 ? "+" : ""
                return "\(sign)\(value) \(type.displayName)"
            }
            .joined(separator: ", ")
    }
}
