//
//  DamageType+DisplayName.swift
//  DestyneaCore
//
//  Created by Willy Kim on 13/11/2026.
//

public extension DamageType {
    var displayName: String {
        switch self {
        case .piercing: return "Perforant"
        case .bludgeoning: return "Contondant"
        case .slashing: return "Tranchant"
        case .fire: return "Feu"
        case .water: return "Eau"
        case .wind: return "Vent"
        case .earth: return "Terre"
        case .darkness: return "Ténèbres"
        case .light: return "Lumière"
        }
    }
}
