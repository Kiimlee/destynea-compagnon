//
//  D100Tests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 13/10/2026.
//

import Testing
@testable import DestyneaCore

@Test(arguments: [0, 101, -3, 150])
func invalidValuesCannotBeRolled(value: Int) {
    #expect(D100(value) == nil)
}

@Test(arguments: [1, 42, 100])
func validValuesCanBeRolled(value: Int) {
    #expect(D100(value)?.value == value)
}
