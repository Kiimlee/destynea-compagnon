//
//  KarmaPurseTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 16/10/2026.
//

import Testing
@testable import DestyneaCore

@Test func addingCopperToEmptyPurseKeepsIt() {
    var purse = KarmaPurse()
    purse.add(.copper)
    #expect(purse.count(of: .copper) == 1)
}

@Test func addingThirdCopperReachesLimit() {
    var purse = KarmaPurse()
    purse.add(.copper)
    purse.add(.copper)
    purse.add(.copper)
    #expect(purse.count(of: .copper) == 3)
}

@Test(arguments: [
    (KarmaCoin.copper, 3),
    (KarmaCoin.silver, 2),
    (KarmaCoin.gold, 1)
])
func addingCoinBeyondLimitIsRefused(coin: KarmaCoin, limit: Int) {
    var purse = KarmaPurse()
    for _ in 1...limit {
        purse.add(coin)
    }
    purse.add(coin)
    #expect(purse.count(of: coin) == limit)
}

@Test func fullCopperDoesNotBlockGold() {
    var purse = KarmaPurse()
    purse.add(.copper)
    purse.add(.copper)
    purse.add(.copper)
    purse.add(.gold)
    #expect(purse.count(of: .gold) == 1)
}
