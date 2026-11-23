//
//  RemoteCreatureRepositoryTests.swift
//  DestyneaCore
//

import Foundation
import Testing
@testable import DestyneaCore

@Test func validResponseReturnsCreatures() async throws {
    let body = jsonData("[\(creatureJSON(name: "Squelette")), \(creatureJSON(name: "Gobelin"))]")
    let repository = RemoteCreatureRepository(url: .bestiaryTestURL, client: StubHTTPClient(statusCode: 200, body: body))

    let creatures = try await repository.fetch()

    #expect(creatures.map(\.name) == ["Squelette", "Gobelin"])
}

@Test func fetchRequestsTheGivenURL() async throws {
    let client = StubHTTPClient(statusCode: 200, body: jsonData("[]"))
    let repository = RemoteCreatureRepository(url: .bestiaryTestURL, client: client)

    _ = try await repository.fetch()

    #expect(await client.requestedURLs == [.bestiaryTestURL])
}

@Test func emptyListIsNotAnError() async throws {
    let repository = RemoteCreatureRepository(url: .bestiaryTestURL, client: StubHTTPClient(statusCode: 200, body: jsonData("[]")))

    let creatures = try await repository.fetch()

    #expect(creatures.isEmpty)
}

@Test(arguments: [404, 500])
func nonSuccessStatusThrowsBadStatus(statusCode: Int) async {
    let repository = RemoteCreatureRepository(url: .bestiaryTestURL, client: StubHTTPClient(statusCode: statusCode, body: jsonData("[]")))

    await #expect(throws: HTTPError.badStatus(code: statusCode)) {
        try await repository.fetch()
    }
}

@Test func networkErrorIsPropagated() async {
    let repository = RemoteCreatureRepository(url: .bestiaryTestURL, client: StubHTTPClient(error: URLError(.notConnectedToInternet)))

    await #expect(throws: URLError.self) {
        try await repository.fetch()
    }
}

@Test func invalidJSONThrows() async {
    let repository = RemoteCreatureRepository(url: .bestiaryTestURL, client: StubHTTPClient(statusCode: 200, body: jsonData("<html>Oups</html>")))

    await #expect(throws: (any Error).self) {
        try await repository.fetch()
    }
}
