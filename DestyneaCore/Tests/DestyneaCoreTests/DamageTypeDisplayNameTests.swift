//
//  DamageType+DisplayName.swift
//  DestyneaCore
//
//  Created by Willy Kim on 13/11/2026.
//

import Testing
@testable import DestyneaCore

@Test(arguments: [
    (DamageType.piercing, "Perforant"),
    (DamageType.bludgeoning, "Contondant"),
    (DamageType.slashing, "Tranchant"),
    (DamageType.fire, "Feu"),
    (DamageType.water, "Eau"),
    (DamageType.wind, "Vent"),
    (DamageType.earth, "Terre"),
    (DamageType.darkness, "Ténèbres"),
    (DamageType.light, "Lumière"),
])
func damageTypeDisplayNamesAreInFrench(type: DamageType, displayName: String) {
    #expect(type.displayName == displayName)
}
