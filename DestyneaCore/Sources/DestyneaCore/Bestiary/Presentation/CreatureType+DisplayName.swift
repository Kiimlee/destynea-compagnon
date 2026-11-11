//
//  CreatureType+DisplayName.swift
//  DestyneaCore
//
//  Created by Willy Kim on 11/11/2026.
//

public extension CreatureType {
    var displayName: String {
        switch self {
        case .boss: return "Boss"
        case .elite: return "Élite"
        case .minion: return "Sbire"
        case .soldier: return "Fantassin"
        }
    }
}
