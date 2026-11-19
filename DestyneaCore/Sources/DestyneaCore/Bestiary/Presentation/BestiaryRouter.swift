//
//  BestiaryRouter.swift
//  DestyneaCore
//
//  Created by Willy Kim on 19/11/2026.
//

import Observation

@MainActor
@Observable
public final class BestiaryRouter {
    public var path = [Creature]()

    public init() {}
    
    public func show(_ creature: Creature) {
        path.append(creature)
    }
    
    public func popToRoot() {
        path.removeAll()
    }
}
