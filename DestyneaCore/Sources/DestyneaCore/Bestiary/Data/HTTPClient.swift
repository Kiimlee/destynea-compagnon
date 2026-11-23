//
//  HTTPClient.swift
//  DestyneaCore
//
//  Created by Willy Kim on 23/11/2026.
//

import Foundation

public protocol HTTPClient: Sendable {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: HTTPClient {
    public func data(from url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url, delegate: nil)
    }
}
