//
//  CachedCreatureRepositoryTests.swift
//  DestyneaCore
//

import Testing
@testable import DestyneaCore

@Test func firstFetchCallsWrappedRepository() async throws {
    let goblin = Creature.fixture(name: "Gobelin")
    let wrapped = SequenceCreatureRepository([.success([goblin])])
    let repository = CachedCreatureRepository(repository: wrapped)

    let creatures = try await repository.fetch()

    #expect(creatures == [goblin])
    #expect(await wrapped.fetchCount == 1)
}

@Test func secondFetchReturnsCachedCreatures() async throws {
    let goblin = Creature.fixture(name: "Gobelin")
    let kraken = Creature.fixture(name: "Kraken", type: .boss)
    let wrapped = SequenceCreatureRepository([.success([goblin]), .success([kraken])])
    let repository = CachedCreatureRepository(repository: wrapped)

    _ = try await repository.fetch()
    let creatures = try await repository.fetch()

    #expect(creatures == [goblin])
    #expect(await wrapped.fetchCount == 1)
}

@Test func fetchErrorIsPropagated() async {
    let wrapped = SequenceCreatureRepository([.failure(SequenceCreatureRepository.FetchError())])
    let repository = CachedCreatureRepository(repository: wrapped)

    await #expect(throws: SequenceCreatureRepository.FetchError.self) {
        try await repository.fetch()
    }
}

@Test func failureIsNotCached() async throws {
    let goblin = Creature.fixture(name: "Gobelin")
    let wrapped = SequenceCreatureRepository([.failure(SequenceCreatureRepository.FetchError()), .success([goblin])])
    let repository = CachedCreatureRepository(repository: wrapped)

    _ = try? await repository.fetch()
    let creatures = try await repository.fetch()

    #expect(creatures == [goblin])
    #expect(await wrapped.fetchCount == 2)
}
