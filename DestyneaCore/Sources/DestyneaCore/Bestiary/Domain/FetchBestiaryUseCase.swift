//
//  FetchBestiaryUseCase.swift
//  DestyneaCore
//
//  Created by Willy Kim on 26/10/2026.
//

import Foundation

public struct FetchBestiaryUseCase: Sendable {
    let repository: CreatureRepository

    public init(repository: any CreatureRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> [Creature] {
        let creatures = try await repository.fetch()
        let sortedCreatures = creatures.sorted { lhs, rhs in
            if lhs.type != rhs.type { return lhs.type < rhs.type }   // 1. le rang d'abord
            return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending // 2. puis le nom
        }
        return sortedCreatures
    }
}
