//
//  Creature.swift
//  DestyneaCore
//
//  Created by Willy Kim on 26/10/2026.
//

struct Creature {
    let name: String
    let type: CreatureType
    let origin: CreatureOrigin
    let size: CreatureSize
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
