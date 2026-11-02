/// Une créature telle qu'elle est écrite dans le JSON : des valeurs brutes, non vérifiées.
/// Elle ne quitte jamais la couche Data : le repository la traduit en `Creature` (Domain).
struct CreatureDTO: Decodable {
    let name: String
    let rank: String            // "minion", "soldier", "elite", "boss"
    let origin: String          // "undead", "humanoid"…
    let size: String            // "S", "M", "L", "XL", "XXL"
    let hitPoints: String       // "4-6" ou "5"
    let movementPoints: Int
    let successRate: String     // "45-55"
    let resistances: [String: Int]   // ["piercing": 1, "bludgeoning": -2]
    let initiative: Int
    let description: String
}
