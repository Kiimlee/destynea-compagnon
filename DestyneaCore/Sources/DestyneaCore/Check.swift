//
//  Check.swift
//  DestyneaCore
//
//  Created by Willy Kim on 12/10/2026.
//

enum Check {
    enum Outcome {
        case success
        case failure
    }

    static func resolve(roll: Int, score: Int) -> Outcome {
        roll <= score ? .success : .failure
    }
}
