//
//  CreatureRepository.swift
//  DestyneaCore
//
//  Created by Willy Kim on 26/10/2026.
//

protocol CreatureRepository {
    func fetch() async throws -> [Creature]
}
