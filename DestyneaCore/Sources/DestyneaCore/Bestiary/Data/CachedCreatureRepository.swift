//
//  CachedCreatureRepository.swift
//  DestyneaCore
//
//  Created by Willy Kim on 24/11/2026.
//

public actor CachedCreatureRepository: CreatureRepository {
    private let repository: any CreatureRepository
    private var task: Task<[Creature], any Error>?

    public init(repository: any CreatureRepository) {
        self.repository = repository
    }

    public func fetch() async throws -> [Creature] {
        if let task = task {
            return try await task.value
        } else {
            return try await refresh()
        }
    }
    
    public func refresh() async throws -> [Creature] {
        let task = Task {
            try await repository.fetch()
        }
        self.task = task
        do {
            return try await task.value
        } catch {
            self.task = nil
            throw error
        }
    }
}
