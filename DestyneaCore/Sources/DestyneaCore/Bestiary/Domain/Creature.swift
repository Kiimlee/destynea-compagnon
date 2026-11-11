//
//  Creature.swift
//  DestyneaCore
//
//  Created by Willy Kim on 26/10/2026.
//

public struct Creature: Equatable, Sendable {
    public let name: String
    public let type: CreatureType
    public let origin: CreatureOrigin?     // nil si inconnue dans les données
    public let size: CreatureSize?         // nil si inconnue dans les données
    public let hitPoints: ClosedRange<Int>
    public let movementPoints: Int
    public let successRate: ClosedRange<Int>
    public let resistances: [DamageType: Int]
    public let initiative: Int
    public let description: String
    public let capacities: [Capacity]
    public let loots: [Loot]
}

/// Le rang d'une créature. L'ordre des `case` définit l'ordre de tri (Comparable).
public enum CreatureType: Comparable, Sendable {
    case minion
    case soldier
    case elite
    case boss
    
    var defaultHitPoints: ClosedRange<Int> {
        switch self {
        case .minion: return 2...4
        case .soldier: return 4...7
        case .elite: return 8...12
        case .boss: return 16...22
        }
    }
    
    var defaultSuccessRate: ClosedRange<Int> {
        switch self {
        case .minion: return 40...50
        case .soldier: return 50...60
        case .elite: return 60...70
        case .boss: return 70...80
        }
    }
}

public enum CreatureOrigin: Sendable {
    case humanoid
    case undead
    case beast
    case elemental
    case abomination
    case floral
    case draconic
    case abyssal
    case divine
    case fantasy
    case demonic
    case astral
    case malevolent
    case bug
    case spectral
}

public enum CreatureSize: Sendable {
    case s
    case m
    case l
    case xl
    case xxl
}

public enum DamageType: Sendable {
    case piercing
    case bludgeoning
    case slashing
    case fire
    case water
    case wind
    case earth
    case darkness
    case light
}

public struct Capacity: Equatable, Sendable {
    public let type: CapacityType
    public let description: String
    public let effects: String
}

public enum CapacityType: Equatable, Sendable {
    case passive
    case active(actionCost: Int, range: Int, rollIsRequired: Bool)
}

public struct Loot: Equatable, Sendable {
    public let type: LootType
    public let rarity: LootRarity
    public let name: String
    public let description: String
}

public enum LootType: Sendable {
    case equipment
    case weapon
    case misc
    case object
    case ingredient
    case money
}

public enum LootRarity: Sendable {
    case common
    case uncommon
    case rare
    case epic
    case legendary
}

extension CreatureType {
    init?(json: String) {
        switch json {
        case "minion": self = .minion
        case "soldier": self = .soldier
        case "elite": self = .elite
        case "boss": self = .boss
        default: return nil          // rang inconnu → nil → monstre ignoré
        }
    }
}

// Identité d'une créature pour les listes SwiftUI : son nom est unique dans un bestiaire.
extension Creature: Identifiable {
    public var id: String { name }
}
