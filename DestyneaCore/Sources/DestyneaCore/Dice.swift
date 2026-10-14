//
//  Dice.swift
//  DestyneaCore
//
//  Created by Willy Kim on 14/10/2026.
//

protocol Dice {
    func roll() -> D100
}

struct RandomDice: Dice {
    func roll() -> D100 {
        return D100(Int.random(in: D100.range))!   // sûr : la plage garantit une valeur valide
    }
}
