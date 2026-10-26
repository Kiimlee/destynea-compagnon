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
