//
//  KarmaCoin.swift
//  DestyneaCore
//
//  Created by Willy Kim on 15/10/2026.
//

enum KarmaCoin {
    case copper, silver, gold
    
    var bonus: Int {
        switch self {
        case .copper: 3
        case .silver: 5
        case .gold:   10
        }
    }
    
    var purseLimit: Int {
        switch self {
        case .copper: 3
        case .silver: 2
        case .gold:   1
        }
    }
    
    static func earned(roll: D100, score: Int) -> KarmaCoin? {
        let result = Check.resolve(roll: roll, score: score)
        guard result == .failure || result == .criticalFailure else { return nil }
        
        switch roll.value {
        case 1...60: return .copper
        case 61...85: return .silver
        default: return .gold
        }
    }
}
