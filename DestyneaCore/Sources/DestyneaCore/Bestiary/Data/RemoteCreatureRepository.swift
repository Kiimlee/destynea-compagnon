//
//  RemoteCreatureRepository.swift
//  DestyneaCore
//
//  Created by Willy Kim on 23/11/2026.
//

import Foundation

public struct RemoteCreatureRepository: CreatureRepository {
    let url: URL
    let client: any HTTPClient

    public init(url: URL, client: any HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func fetch() async throws -> [Creature] {
        let (data, response) = try await client.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        switch httpResponse.statusCode {
        case 200...299:
            return try await JSONCreatureRepository(data: data).fetch()
        default:
            throw HTTPError.badStatus(code: httpResponse.statusCode)
        }
    }
}
