//
//  KarmaCoinTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 15/10/2026.
//

import Testing
@testable import DestyneaCore

@Test func successfulRollEarnsNoCoin() throws {
    let roll = try #require(D100(80))
    let karmaCoin = KarmaCoin.earned(roll: roll, score: 88)
    #expect(karmaCoin == nil)
}

@Test(arguments: [
    (40, 30, KarmaCoin.copper),
    (60, 10, KarmaCoin.copper),
    (61, 50, KarmaCoin.silver),
    (85, 60, KarmaCoin.silver),
    (86, 70, KarmaCoin.gold),
    (97, 99, KarmaCoin.gold)
])
func failedRollEarnsCoinByRollValue(roll: Int, score: Int, expected: KarmaCoin) throws {
    let roll = try #require(D100(roll))
    let karmaCoin = KarmaCoin.earned(roll: roll, score: score)
    #expect(karmaCoin == expected)
}

@Test(arguments: [
    (KarmaCoin.copper, 3),
    (KarmaCoin.silver, 5),
    (KarmaCoin.gold, 10)
])
func coinBonusMatchesRules(coin: KarmaCoin, expectedBonus: Int) {
    #expect(coin.bonus == expectedBonus)
}
