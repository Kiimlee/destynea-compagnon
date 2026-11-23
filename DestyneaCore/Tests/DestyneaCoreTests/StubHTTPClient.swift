//
//  StubHTTPClient.swift
//  DestyneaCore
//

import Foundation
@testable import DestyneaCore

/// Faux client HTTP : renvoie une réponse préparée (ou une erreur) sans toucher au réseau,
/// et retient l'URL demandée pour qu'un test puisse la vérifier.
/// `actor` car il a un état modifiable (`requestedURLs`) et doit être `Sendable`.
actor StubHTTPClient: HTTPClient {
    private let result: Result<(Data, URLResponse), any Error>
    private(set) var requestedURLs: [URL] = []

    init(statusCode: Int, body: Data) {
        let response = HTTPURLResponse(url: .bestiaryTestURL, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        result = .success((body, response))
    }

    init(error: any Error) {
        result = .failure(error)
    }

    func data(from url: URL) async throws -> (Data, URLResponse) {
        requestedURLs.append(url)
        return try result.get()
    }
}

extension URL {
    static let bestiaryTestURL = URL(string: "https://example.com/bestiary.json")!
}
