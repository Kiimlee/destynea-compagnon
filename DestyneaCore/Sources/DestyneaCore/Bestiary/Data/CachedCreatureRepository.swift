//
//  CachedCreatureRepository.swift
//  DestyneaCore
//
//  Created by Willy Kim on 24/11/2026.
//

public actor CachedCreatureRepository: CreatureRepository {
    private let repository: any CreatureRepository
    private var creatures: [Creature]?

    public init(repository: any CreatureRepository) {
        self.repository = repository
    }

    public func fetch() async throws -> [Creature] {
        if let cache = creatures {
            return cache
        } else {
            return try await refresh()
        }
    }
    
    public func refresh() async throws -> [Creature] {
        let newCreatures = try await repository.fetch()
        creatures = newCreatures
        return newCreatures
    }
}
