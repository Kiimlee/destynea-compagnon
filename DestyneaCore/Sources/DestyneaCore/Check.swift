//
//  Check.swift
//  DestyneaCore
//
//  Created by Willy Kim on 12/10/2026.
//

enum Check {
    enum Outcome {
        case success
        case criticalSuccess
        case failure
        case criticalFailure
    }

    static func resolve(roll: D100, score: Int) -> Outcome {
        switch roll.value {
        case 1...5: .criticalSuccess
        case 96...100: .criticalFailure
        case ...score: .success
        default: .failure
        }
    }
    
    static func roll(score: Int, using dice: Dice = RandomDice()) -> Outcome {
        return self.resolve(roll: dice.roll(), score: score)
    }
}
