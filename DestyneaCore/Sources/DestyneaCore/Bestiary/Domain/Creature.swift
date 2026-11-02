//
//  Creature.swift
//  DestyneaCore
//
//  Created by Willy Kim on 26/10/2026.
//

struct Creature {
    let name: String
    let type: CreatureType
    let origin: CreatureOrigin?     // nil si inconnue dans les données
    let size: CreatureSize?         // nil si inconnue dans les données
    let hitPoints: ClosedRange<Int>
    let movementPoints: Int
    let successRate: ClosedRange<Int>
    let resistances: [DamageType: Int]
    let initiative: Int
    let description: String
    let capacities: [Capacity]
    let loots: [Loot]
}

/// Le rang d'une créature. L'ordre des `case` définit l'ordre de tri (Comparable).
enum CreatureType: Comparable {
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

enum CreatureOrigin {
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

enum CreatureSize {
    case s
    case m
    case l
    case xl
    case xxl
}

enum DamageType {
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

struct Capacity {
    let type: CapacityType
    let description: String
    let effects: String
}

enum CapacityType {
    case passive
    case active(actionCost: Int, range: Int, rollIsRequired: Bool)
}

struct Loot {
    let type: LootType
    let rarity: LootRarity
    let name: String
    let description: String
}

enum LootType {
    case equipment
    case weapon
    case misc
    case object
    case ingredient
    case money
}

enum LootRarity {
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
