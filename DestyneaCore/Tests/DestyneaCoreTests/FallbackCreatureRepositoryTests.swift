//
//  FallbackCreatureRepositoryTests.swift
//  DestyneaCore
//

import Testing
@testable import DestyneaCore

@Test func primarySuccessIsUsed() async throws {
    let goblin = Creature.fixture(name: "Gobelin")
    let kraken = Creature.fixture(name: "Kraken", type: .boss)
    let repository = FallbackCreatureRepository(
        primary: StubCreatureRepository(creatures: [goblin]),
        fallback: StubCreatureRepository(creatures: [kraken])
    )

    #expect(try await repository.fetch() == [goblin])
}

@Test func primaryFailureUsesFallback() async throws {
    let kraken = Creature.fixture(name: "Kraken", type: .boss)
    let repository = FallbackCreatureRepository(
        primary: FailingCreatureRepository(),
        fallback: StubCreatureRepository(creatures: [kraken])
    )

    #expect(try await repository.fetch() == [kraken])
}

@Test func bothFailingThrows() async {
    let repository = FallbackCreatureRepository(
        primary: FailingCreatureRepository(),
        fallback: FailingCreatureRepository()
    )

    await #expect(throws: FailingCreatureRepository.FetchError.self) {
        try await repository.fetch()
    }
}
