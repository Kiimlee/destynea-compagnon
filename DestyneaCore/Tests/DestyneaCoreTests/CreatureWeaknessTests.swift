//
//  CreatureWeaknessTests.swift
//  DestyneaCore
//

import Testing
@testable import DestyneaCore

@Test func negativeResistanceIsAWeakness() {
    let creature = Creature.fixture(resistances: [.fire: -1])
    #expect(creature.isWeak(to: .fire))
}

@Test(arguments: [1, 0])
func zeroOrPositiveResistanceIsNotAWeakness(value: Int) {
    let creature = Creature.fixture(resistances: [.fire: value])
    #expect(!creature.isWeak(to: .fire))
}

@Test func missingDamageTypeIsNotAWeakness() {
    let creature = Creature.fixture(resistances: [.water: -2])
    #expect(!creature.isWeak(to: .fire))
}
