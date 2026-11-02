//
//  CreatureDTOMappingTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 02/11/2026.
//

import Testing
@testable import DestyneaCore

@Test func validDTOIsFullyTranslated() {
    let creature = CreatureDTO.fixture().toDomain()
    #expect(creature?.name == "Squelette")
    #expect(creature?.type == .minion)
    #expect(creature?.origin == .undead)
    #expect(creature?.size == .m)
    #expect(creature?.hitPoints == 4...6)
    #expect(creature?.successRate == 45...55)
    #expect(creature?.resistances[.piercing] == 1)
}

@Test func unknownRankDropsTheCreature() {
    let creature = CreatureDTO.fixture(rank: "dragon").toDomain()
    #expect(creature == nil)
}

@Test(arguments: ["5", "quatre", "6-4"])
func invalidHitPointsFallBackToRankDefault(hitPoints: String) {
    let creature = CreatureDTO.fixture(rank: "minion", hitPoints: hitPoints).toDomain()
    #expect(creature?.hitPoints == 2...4)
}

@Test(arguments: ["50", "cinquante", "55-45"])
func invalidSuccessRateFallsBackToRankDefault(successRate: String) {
    let creature = CreatureDTO.fixture(rank: "minion", successRate: successRate).toDomain()
    #expect(creature?.successRate == 40...50)
}

@Test func unknownOriginIsIgnoredButCreatureIsKept() {
    let creature = CreatureDTO.fixture(origin: "alien").toDomain()
    #expect(creature != nil)
    #expect(creature?.origin == nil)
}

@Test func unknownSizeIsIgnoredButCreatureIsKept() {
    let creature = CreatureDTO.fixture(size: "XS").toDomain()
    #expect(creature != nil)
    #expect(creature?.size == nil)
}

@Test func unknownResistanceIsDroppedButCreatureIsKept() {
    let creature = CreatureDTO.fixture(resistances: ["piercing": 1, "psychic": 2]).toDomain()
    #expect(creature?.resistances.count == 1)
    #expect(creature?.resistances[.piercing] == 1)
}
