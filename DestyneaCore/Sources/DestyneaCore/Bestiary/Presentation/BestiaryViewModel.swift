//
//  BestiaryViewModel.swift
//  DestyneaCore
//
//  Created by Willy Kim on 10/11/2026.
//

import Observation

enum BestiaryState: Equatable {
    case loading
    case loaded([Creature])
    case empty
    case failed
}

@MainActor
@Observable
final class BestiaryViewModel {
    private(set) var state: BestiaryState = .loading
    private let useCase: FetchBestiaryUseCase

    init(useCase: FetchBestiaryUseCase) { self.useCase = useCase }

    func load() async {
        state = .loading
        do {
            state = state(for: try await useCase.execute())
        } catch {
            state = .failed
        }
    }

    func refresh() async {
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
