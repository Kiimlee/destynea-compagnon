import Foundation

// Traduction DTO (Data) → Creature (Domain).
// Les tables de correspondance « texte JSON → enum » sont prêtes ;
// les DÉCISIONS (rang, fourchettes, valeurs par défaut) sont à écrire en TDD.
extension CreatureDTO {

    func toDomain() -> Creature? {
        guard let rank = CreatureType(json: rank) else { return nil }
    
        let finalHitPoints = self.parseRange(hitPoints) ?? rank.defaultHitPoints
        let finalSuccessRate = self.parseRange(successRate) ?? rank.defaultSuccessRate
        let finalOrigin = CreatureOrigin(json: origin)
        let finalSize = CreatureSize(json: size)
        
        var knownResistances: [DamageType: Int] = [:]
        for (key, value) in resistances {
            if let damageType = DamageType(json: key) {
                knownResistances[damageType] = value
            }
        }
    
        let creature = Creature(name: name,
                                type: rank,
                                origin: finalOrigin,
                                size: finalSize,
                                hitPoints: finalHitPoints,
                                movementPoints: movementPoints,
                                successRate: finalSuccessRate,
                                resistances: knownResistances,
                                initiative: initiative,
                                description: description,
                                capacities: [],
                                loots: []
        )
        return creature
    }

    /// "4-6" → 4...6. Renvoie nil si le format est invalide ("5", "quatre", "6-4").
    func parseRange(_ text: String) -> ClosedRange<Int>? {
        let parts = text.split(separator: "-")      // "4-6" → ["4", "6"]
        guard parts.count == 2,
              let low = Int(parts[0]),
              let high = Int(parts[1]),
              low <= high                            // ⚠️ sinon 6...4 fait crasher Swift
        else { return nil }
        return low...high
    }
}

// MARK: - Tables de correspondance (prêtes)

extension CreatureOrigin {
    init?(json: String) {
        switch json {
        case "humanoid": self = .humanoid
        case "undead": self = .undead
        case "beast": self = .beast
        case "elemental": self = .elemental
        case "abomination": self = .abomination
        case "floral": self = .floral
        case "draconic": self = .draconic
        case "abyssal": self = .abyssal
        case "divine": self = .divine
        case "fantasy": self = .fantasy
        case "demonic": self = .demonic
        case "astral": self = .astral
        case "malevolent": self = .malevolent
        case "bug": self = .bug
        case "spectral": self = .spectral
        default: return nil
        }
    }
}

extension CreatureSize {
    init?(json: String) {
        switch json {
        case "S": self = .s
        case "M": self = .m
        case "L": self = .l
        case "XL": self = .xl
        case "XXL": self = .xxl
        default: return nil
        }
    }
}

extension DamageType {
    init?(json: String) {
        switch json {
        case "piercing": self = .piercing
        case "bludgeoning": self = .bludgeoning
        case "slashing": self = .slashing
        case "fire": self = .fire
        case "water": self = .water
        case "wind": self = .wind
        case "earth": self = .earth
        case "darkness": self = .darkness
        case "light": self = .light
        default: return nil
        }
    }
}
