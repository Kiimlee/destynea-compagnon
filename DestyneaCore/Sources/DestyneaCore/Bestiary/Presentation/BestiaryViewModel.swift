//
//  BestiaryViewModel.swift
//  DestyneaCore
//
//  Created by Willy Kim on 10/11/2026.
//

import Foundation   // localizedStandardCompare
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
    public var weaknessFilter: DamageType?                 // nil = toutes les faiblesses
    public var rankFilter: CreatureType?                   // nil = tous les rangs
    public var sortOrder: BestiarySortOrder = .byName      // PO : alphabétique par défaut
    private let useCase: FetchBestiaryUseCase

    /// Dérivée de `state` + filtres + tri : la liste complète reste intacte dans `state` (une seule source de vérité).
    public var visibleCreatures: [Creature] {
        guard case .loaded(let creatures) = state else { return [] }

        var result = creatures                             // déjà triée par rang puis nom (UseCase)
        if let rankFilter {
            result = result.filter { $0.type == rankFilter }
        }
        if let weaknessFilter {
            result = result.filter { $0.isWeak(to: weaknessFilter) }
        }
        if sortOrder == .byName {
            result.sort { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        }
        return result
    }

    /// Ce que la liste affiche : une section sans en-tête (par nom) ou une section par rang non vide (par rang).
    public var sections: [BestiarySection] {
        let creatures = visibleCreatures
        guard !creatures.isEmpty else { return [] }

        switch sortOrder {
        case .byName:
            return [BestiarySection(rank: nil, creatures: creatures)]
        case .byRank:
            return CreatureType.allCases.compactMap { rank in
                let ofRank = creatures.filter { $0.type == rank }
                return ofRank.isEmpty ? nil : BestiarySection(rank: rank, creatures: ofRank)
            }
        }
    }

    public var hasActiveFilter: Bool {
        weaknessFilter != nil || rankFilter != nil
    }

    public func resetFilters() {
        weaknessFilter = nil
        rankFilter = nil
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
