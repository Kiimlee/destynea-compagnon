//
//  ClosedRangeDisplayTextTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 13/11/2026.
//


import Testing
@testable import DestyneaCore

@Test(arguments: [
    (5...5, "5"),
    (2...4, "2 à 4"),
])
func rangeDisplayTextShowsOneNumberOrBothBounds(range: ClosedRange<Int>, expected: String) {
    #expect(range.displayText == expected)
}
