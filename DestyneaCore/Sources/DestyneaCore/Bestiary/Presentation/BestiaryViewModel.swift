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
    private let useCase: FetchBestiaryUseCase

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
            state = state(for: try await useCase.execute())
        } catch {
            print("keep previous list")
        }
    }
    
    private func state(for creatures: [Creature]) -> BestiaryState {
        creatures.isEmpty ? .empty : .loaded(creatures)
    }
}
