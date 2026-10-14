//
//  LoadedDice.swift
//  DestyneaCore
//
//  Created by Willy Kim on 14/10/2026.
//

@testable import DestyneaCore

struct LoadedDice: Dice {
    let value: D100

    func roll() -> D100 {
        return value
    }
}
