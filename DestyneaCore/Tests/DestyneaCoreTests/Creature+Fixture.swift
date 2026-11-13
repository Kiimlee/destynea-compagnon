@testable import DestyneaCore

extension Creature {
    /// Crée une créature de test : seuls le nom et le rang comptent pour la plupart des tests.
    static func fixture(name: String = "Gobelin", type: CreatureType = .minion, hitPoints: ClosedRange<Int> = 2...4, successRate: ClosedRange<Int> = 40...50) -> Creature {
        Creature(
            name: name,
            type: type,
            origin: .humanoid,
            size: .m,
            hitPoints: hitPoints,
            movementPoints: 5,
            successRate: successRate,
            resistances: [:],
            initiative: 0,
            description: "",
            capacities: [],
            loots: []
        )
    }
}
