//
//  FetchBestiaryUseCaseTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 26/10/2026.
//

import Testing
@testable import DestyneaCore

@Test func bestiaryIsSortedByRank() async throws {
    let useCase = FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [
        .fixture(name: "Zombie", type: .soldier),
        .fixture(name: "Gobelin", type: .minion),
        .fixture(name: "Nécromancien", type: .elite),
        .fixture(name: "Jeune dragofeu", type: .boss)
    ]))
    let result = try await useCase.execute()
    #expect(result.map(\.name) == ["Gobelin", "Zombie", "Nécromancien", "Jeune dragofeu"])
}

@Test func sameRankIsSortedAlphabetically() async throws {
    let useCase = FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [
        .fixture(name: "Squelette", type: .minion),
        .fixture(name: "Gobelin", type: .minion),
    ]))
    let result = try await useCase.execute()
    #expect(result.map(\.name) == ["Gobelin", "Squelette"])
}

@Test func rankWinsOverName() async throws {
    let useCase = FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [
        .fixture(name: "Zombie", type: .minion),
        .fixture(name: "Abomination", type: .boss),
    ]))
    let result = try await useCase.execute()
    #expect(result.map(\.name) == ["Zombie", "Abomination"])
}

@Test func emptyBestiaryGivesEmptyList() async throws {
    let useCase = FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: []))
    let result = try await useCase.execute()
    #expect(result.isEmpty)
}

@Test func accentedNamesAreSortedLikeInFrench() async throws {
    let useCase = FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [
        .fixture(name: "Gobelin", type: .minion),
        .fixture(name: "Élémentaire", type: .minion),
    ]))
    let result = try await useCase.execute()
    #expect(result.map(\.name) == ["Élémentaire", "Gobelin"])
}

@Test func repositoryErrorIsPropagated() async throws {
    let useCase = FetchBestiaryUseCase(repository: FailingCreatureRepository())
    
    await #expect(throws: FailingCreatureRepository.FetchError.self) {
        try await useCase.execute()
    }
}

@Test func executeUsesFetchByDefault() async throws {
    let goblin = Creature.fixture(name: "Gobelin")
    let useCase = FetchBestiaryUseCase(repository: RefreshableStubRepository(fetched: [goblin], refreshed: []))

    #expect(try await useCase.execute() == [goblin])
}

@Test func forcedRefreshAsksRepositoryToRefresh() async throws {
    let kraken = Creature.fixture(name: "Kraken", type: .boss)
    let useCase = FetchBestiaryUseCase(repository: RefreshableStubRepository(fetched: [], refreshed: [kraken]))

    #expect(try await useCase.execute(forceRefresh: true) == [kraken])
}
