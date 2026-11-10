//
//  CreatureRepository.swift
//  DestyneaCore
//
//  Created by Willy Kim on 26/10/2026.
//

protocol CreatureRepository: Sendable {
    func fetch() async throws -> [Creature]
}
