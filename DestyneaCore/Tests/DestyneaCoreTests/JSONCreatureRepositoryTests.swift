//
//  JSONCreatureRepositoryTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 09/11/2026.
//

import Testing
@testable import DestyneaCore

@Test func twoValidCreaturesAreLoaded() async throws {
    let repository = JSONCreatureRepository(data: jsonData("[\(creatureJSON()), \(creatureJSON(name: "Gobelin"))]"))
    let creatures = try await repository.fetch()
    #expect(creatures.map(\.name) == ["Squelette", "Gobelin"])
}

@Test func emptyListWithoutError() async throws {
    let repository = JSONCreatureRepository(data: jsonData("[]"))
    let creatures = try await repository.fetch()
    #expect(creatures.isEmpty)
}

@Test func fetchReturnsErrorWithInvalidJSON() async throws {
    let repository = JSONCreatureRepository(data: jsonData("ceci n'est pas du json"))
    await #expect(throws: (any Error).self) { try await repository.fetch() }
}

@Test func fetchReturnsErrorWithInvalidData() async throws {
    let repository = JSONCreatureRepository(data: jsonData("{}"))
    await #expect(throws: (any Error).self) { try await repository.fetch() }
}

@Test func malformedCreatureIsSkippedOthersAreKept() async throws {
    let repository = JSONCreatureRepository(data: jsonData("[\(creatureJSON()),\(creatureJSON(movementPoints: "\"cinq\"")), \(creatureJSON(name: "Gobelin"))]"))
    let creatures = try await repository.fetch()
    #expect(creatures.map(\.name) == ["Squelette", "Gobelin"])
}

@Test func unknownRankCreatureIsSkippedOthersAreKept() async throws {
    let repository = JSONCreatureRepository(data: jsonData("[\(creatureJSON()), \(creatureJSON(rank: "dragon")), \(creatureJSON(name: "Gobelin"))]"))
    let creatures = try await repository.fetch()
    #expect(creatures.map(\.name) == ["Squelette", "Gobelin"])
}
