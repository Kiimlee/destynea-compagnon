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

@Test func copiedPurseIsIndependent() {
    let kiimleePurse = KarmaPurse()
    var nyxPurse = kiimleePurse
    nyxPurse.add(.gold)
    #expect(kiimleePurse.count(of: .gold) == 0)
}

@Test func spendingCopperGivesThreeAndRemovesIt() throws {
    var purse = KarmaPurse()
    purse.add(.copper)
    let result = try purse.spend([.copper])
    #expect(result == 3)
    #expect(purse.count(of: .copper) == 0)
}

@Test func spendCoinsOfEach() throws {
    var purse = KarmaPurse()
    purse.add(.copper)
    purse.add(.silver)
    purse.add(.gold)
    let result = try purse.spend([.copper, .silver, .gold])
    #expect(result == 18)
}

@Test func spendingNothingGivesZeroAndKeepsPurse() throws {
    var purse = KarmaPurse()
    purse.add(.copper)
    let result = try purse.spend([])
    #expect(result == 0)
    #expect(purse.count(of: .copper) == 1)
}

@Test func spendWithEmptyPurse() throws {
    var purse = KarmaPurse()
    #expect(throws: KarmaPurseError.coinNotOwned(.gold)) {
        try purse.spend([.gold])
    }
}

@Test func failedSpendKeepsAllCoins() throws {
    var purse = KarmaPurse()
    purse.add(.copper)
    #expect(throws: KarmaPurseError.coinNotOwned(.gold)) {
        try purse.spend([.copper, .gold])
    }
    #expect(purse.count(of: .copper) == 1)
}

@Test func spendOneCoinIsIndependent() throws {
    var purse = KarmaPurse()
    purse.add(.copper)
    purse.add(.silver)
    let _ = try purse.spend([.copper])
    #expect(purse.count(of: .silver) == 1)
}

@Test func losingUnusedCoinsEmptiesEveryType() {
    var purse = KarmaPurse()
    purse.add(.copper)
    purse.add(.silver)
    purse.add(.gold)
    purse.loseUnusedCoins()
    #expect(purse.count(of: .copper) == 0)
    #expect(purse.count(of: .silver) == 0)
    #expect(purse.count(of: .gold) == 0)
}

@Test func losingCoinsFromEmptyPurseDoesNothing() {
    var purse = KarmaPurse()
    purse.loseUnusedCoins()
    #expect(purse.count(of: .copper) == 0)
    #expect(purse.count(of: .silver) == 0)
    #expect(purse.count(of: .gold) == 0)
}
