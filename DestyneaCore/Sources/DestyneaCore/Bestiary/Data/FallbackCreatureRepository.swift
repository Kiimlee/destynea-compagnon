//
//  FallbackCreatureRepository.swift
//  DestyneaCore
//
//  Created by Willy Kim on 24/11/2026.
//

public struct FallbackCreatureRepository: CreatureRepository {
    let primary: any CreatureRepository
    let fallback: any CreatureRepository
    
    public init(primary: any CreatureRepository, fallback: any CreatureRepository) {
        self.primary = primary
        self.fallback = fallback
    }
    
    public func fetch() async throws -> [Creature] {
        do {
            return try await primary.fetch()
        } catch {
            return try await fallback.fetch()
        }
    }
}
