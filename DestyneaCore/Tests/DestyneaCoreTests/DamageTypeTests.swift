//
//  DamageTypeTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 13/11/2026.
//

import Testing
@testable import DestyneaCore

@Test(arguments: [
    DamageType.piercing,
    DamageType.bludgeoning,
    DamageType.slashing
])
func physicalDamageTypesArePhysical(damageType: DamageType) {
    #expect(damageType.category == .physical)
}

@Test(arguments: [
    DamageType.fire,
    DamageType.water,
    DamageType.wind,
    DamageType.earth,
    DamageType.darkness,
    DamageType.light
])
func elementalDamageTypesAreElemental(damageType: DamageType) {
    #expect(damageType.category == .elemental)
}

@Test func physicalDamagesComeBeforeElementalOnes() {
    #expect([DamageType.light, .fire, .piercing, .slashing].sorted() == [.piercing, .slashing, .fire, .light])
}
