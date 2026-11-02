//
//  CreatureTypeTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 02/11/2026.
//

import Testing
@testable import DestyneaCore

@Test(arguments: [
    (CreatureType.minion,  2...4,   40...50),
    (CreatureType.soldier, 4...7,   50...60),
    (CreatureType.elite,   8...12,  60...70),
    (CreatureType.boss,    16...22, 70...80)
])
func defaultStatsMatchLevelOneRules(type: CreatureType, hitPoints: ClosedRange<Int>, successRate: ClosedRange<Int>) {
    #expect(type.defaultHitPoints == hitPoints)
    #expect(type.defaultSuccessRate == successRate)
}
