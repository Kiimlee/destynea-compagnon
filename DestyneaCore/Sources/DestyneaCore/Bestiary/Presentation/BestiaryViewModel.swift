//
//  BestiaryViewModel.swift
//  DestyneaCore
//
//  Created by Willy Kim on 10/11/2026.
//

import Observation

public enum BestiaryState: Equatable, Sendable {
    case loading
    case loaded([Creature])
    case empty
    case failed
}

@MainActor
@Observable
public final class BestiaryViewModel {
    public private(set) var state: BestiaryState = .loading
    public var weaknessFilter: DamageType?                 // nil = « Tous »
    private let useCase: FetchBestiaryUseCase

    /// Dérivée de `state` + filtre : la liste complète reste intacte dans `state` (une seule source de vérité).
    public var visibleCreatures: [Creature] {
        guard case .loaded(let creatures) = state else {
            return []
        }
        
        if let weaknessFilter {
            return creatures.filter { $0.isWeak(to: weaknessFilter) }
        } else {
            return creatures
        }
    }

    public init(useCase: FetchBestiaryUseCase) { self.useCase = useCase }

    public func load() async {
        state = .loading
        do {
            state = state(for: try await useCase.execute())
        } catch {
            state = .failed
        }
    }

    public func refresh() async {
        do {
            state = state(for: try await useCase.execute(forceRefresh: true))
        } catch {
            // A failed refresh keeps the list already shown.
        }
    }
    
    private func state(for creatures: [Creature]) -> BestiaryState {
        creatures.isEmpty ? .empty : .loaded(creatures)
    }
}
