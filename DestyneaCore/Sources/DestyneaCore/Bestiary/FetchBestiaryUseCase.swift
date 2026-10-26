//
//  FetchBestiaryUseCase.swift
//  DestyneaCore
//
//  Created by Willy Kim on 26/10/2026.
//

struct FetchBestiaryUseCase {
    let repository: CreatureRepository
    
    func execute() async throws -> [Creature] {
        let creatures = try await repository.fetch()
        return creatures.sorted { $0.type < $1.type }
    }
}
