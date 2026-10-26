@testable import DestyneaCore

extension Creature {
    /// Crée une créature de test : seuls le nom et le rang comptent pour la plupart des tests.
    static func fixture(name: String = "Gobelin", type: CreatureType = .minion) -> Creature {
        Creature(
            name: name,
            type: type,
            origin: .humanoid,
            size: .m,
            hitPoints: 2...4,
            movementPoints: 5,
            successRate: 40...50,
            resistances: [:],
            initiative: 0,
            description: "",
            capacities: [],
            loots: []
        )
    }
}
