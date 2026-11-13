//
//  ResistancesDisplayTextTests.swift
//  DestyneaCore
//

import Testing
@testable import DestyneaCore

@Test(arguments: [
    ([DamageType.fire: 2], "+2 Feu"),
    ([DamageType.water: -2], "-2 Eau"),
])
func resistanceShowsSignedValueAndName(resistances: [DamageType: Int], expected: String) {
    #expect(resistances.displayText == expected)
}

@Test func resistancesFollowTheDamageTypeOrder() {
    let resistances: [DamageType: Int] = [.light: -2, .darkness: 1, .bludgeoning: -2, .piercing: 1]
    #expect(resistances.displayText == "+1 Perforant, -2 Contondant, +1 Ténèbres, -2 Lumière")
}

@Test func zeroResistanceIsHidden() {
    let resistances: [DamageType: Int] = [.fire: 2, .water: 0]
    #expect(resistances.displayText == "+2 Feu")
}

@Test(arguments: [
    [DamageType: Int](),
    [DamageType.fire: 0, .water: 0],
])
func noResistanceShowsNeutralText(resistances: [DamageType: Int]) {
    #expect(resistances.displayText == "Aucune résistance ni faiblesse")
}
