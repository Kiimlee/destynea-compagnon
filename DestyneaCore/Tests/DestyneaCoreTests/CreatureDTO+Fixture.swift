@testable import DestyneaCore

extension CreatureDTO {
    /// Le squelette de ton bestiaire, valide par défaut : chaque test ne change que le champ qui l'intéresse.
    static func fixture(
        name: String = "Squelette",
        rank: String = "minion",
        origin: String = "undead",
        size: String = "M",
        hitPoints: String = "4-6",
        successRate: String = "45-55",
        resistances: [String: Int] = ["piercing": 1, "bludgeoning": -2]
    ) -> CreatureDTO {
        CreatureDTO(
            name: name,
            rank: rank,
            origin: origin,
            size: size,
            hitPoints: hitPoints,
            movementPoints: 5,
            successRate: successRate,
            resistances: resistances,
            initiative: -1,
            description: "Des os blanchis qui cliquettent dans le silence."
        )
    }
}
