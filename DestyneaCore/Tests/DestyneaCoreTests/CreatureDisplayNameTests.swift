//
//  CreatureDisplayNameTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 11/11/2026.
//

import Testing
@testable import DestyneaCore


@Test(arguments: [
    (CreatureType.minion, "Sbire"),
    (CreatureType.soldier, "Fantassin"),
    (CreatureType.elite, "Élite"),
    (CreatureType.boss, "Boss")
])
func rankDisplayNamesAreInFrench(type: CreatureType, displayName: String) {
    #expect(type.displayName == displayName)
}
