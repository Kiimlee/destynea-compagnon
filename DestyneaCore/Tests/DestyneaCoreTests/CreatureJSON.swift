import Foundation

/// Fabrique le JSON d'une créature pour les tests.
/// `movementPoints` est du JSON brut : `"5"` (valide) ou `"\"cinq\""` (mauvais type, pour casser le décodage).
func creatureJSON(name: String = "Squelette", rank: String = "minion", movementPoints: String = "5") -> String {
    """
    {
      "name": "\(name)",
      "rank": "\(rank)",
      "origin": "undead",
      "size": "M",
      "hitPoints": "4-6",
      "movementPoints": \(movementPoints),
      "successRate": "45-55",
      "resistances": { "piercing": 1 },
      "initiative": -1,
      "description": "Test"
    }
    """
}

/// Transforme un texte JSON en `Data`, comme le contenu d'un fichier.
func jsonData(_ text: String) -> Data {
    Data(text.utf8)
}
