//
//  FetchBestiaryUseCaseTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 26/10/2026.
//

import Testing
@testable import DestyneaCore

@Test func fetchBestiaryAndIsSortedByType() async throws {
    let useCase = FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [
        .fixture(name: "Zombie", type: .soldier),
        .fixture(name: "Gobelin", type: .minion),
        .fixture(name: "Nécromancien", type: .elite),
        .fixture(name: "Jeune dragofeu", type: .boss)
    ]))
    let result = try await useCase.execute()
    #expect(result.map(\.name) == ["Gobelin", "Zombie", "Nécromancien", "Jeune dragofeu"])
}

@Test func fetchBestiaryAndIsSortedByLetters() async throws {
    let useCase = FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [
        .fixture(name: "Squelette", type: .minion),
        .fixture(name: "Gobelin", type: .minion),
    ]))
    let result = try await useCase.execute()
    #expect(result.map(\.name) == ["Gobelin", "Squelette"])
}

@Test func fetchBestiaryAndIsSortedByRank() async throws {
    let useCase = FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [
        .fixture(name: "Zombie", type: .minion),
        .fixture(name: "Abomination", type: .boss),
    ]))
    let result = try await useCase.execute()
    #expect(result.map(\.name) == ["Zombie", "Abomination"])
}

@Test func fetchBestiaryAndIsEmpty() async throws {
    let useCase = FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: []))
    let result = try await useCase.execute()
    #expect(result.isEmpty)
}

@Test func fetchBestiaryAndIsSortedLetter2() async throws {
    let useCase = FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [
        .fixture(name: "Gobelin", type: .minion),
        .fixture(name: "Élémentaire", type: .minion),
    ]))
    let result = try await useCase.execute()
    #expect(result.map(\.name) == ["Élémentaire", "Gobelin"])
}

@Test func fetchBestiaryAndErrorIsHandled() async throws {
    let useCase = FetchBestiaryUseCase(repository: FailingCreatureRepository())
    
    await #expect(throws: FailingCreatureRepository.FetchError.self) {
        try await useCase.execute()
    }
}
