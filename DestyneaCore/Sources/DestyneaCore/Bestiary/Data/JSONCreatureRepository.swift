//
//  JSONCreatureRepository.swift
//  DestyneaCore
//
//  Created by Willy Kim on 09/11/2026.
//

import Foundation

public struct JSONCreatureRepository: CreatureRepository {
    let data: Data

    public init(data: Data) {
        self.data = data
    }

    public func fetch() async throws -> [Creature] {
        let items = try JSONDecoder().decode([Lenient<CreatureDTO>].self, from: data)
        return items.compactMap { $0.value?.toDomain() }
    }
}

/// Décode un élément SANS faire échouer tout le tableau : s'il est cassé, `value` vaut nil.
private struct Lenient<T: Decodable>: Decodable {
    let value: T?
    init(from decoder: Decoder) throws {
        value = try? T(from: decoder)
    }
}
