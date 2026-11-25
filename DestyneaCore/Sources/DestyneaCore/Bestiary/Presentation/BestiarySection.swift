//
//  BestiarySection.swift
//  DestyneaCore
//

/// Un groupe de monstres à afficher. `rank == nil` → pas d'en-tête (tri par nom, une seule liste).
public struct BestiarySection: Identifiable, Equatable, Sendable {
    public let rank: CreatureType?
    public let creatures: [Creature]

    public var id: String { rank?.displayName ?? "all" }
}
