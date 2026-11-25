//
//  BestiarySortOrder.swift
//  DestyneaCore
//
//  Created by Willy Kim on 25/11/2026.
//

/// L'ordre d'affichage choisi à l'écran (choix d'affichage → Presentation, pas Domain).
public enum BestiarySortOrder: CaseIterable, Sendable {
    case byName     // par défaut : A → Z, une seule liste
    case byRank     // groupé en sections : Sbires, Fantassins, Élites, Boss

    public var displayName: String {
        switch self {
        case .byName: return "Nom"
        case .byRank: return "Rang"
        }
    }
}
