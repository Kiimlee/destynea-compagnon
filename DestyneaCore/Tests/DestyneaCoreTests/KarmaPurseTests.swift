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
