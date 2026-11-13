//
//  ClosedRange+DisplayText.swift
//  DestyneaCore
//
//  Created by Willy Kim on 13/11/2026.
//

public extension ClosedRange<Int> {
    var displayText: String {
        if lowerBound == upperBound {
            return "\(lowerBound)"
        } else {
            return "\(lowerBound) à \(upperBound)"
        }
    }
}
