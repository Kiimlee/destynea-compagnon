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
            let result = try await useCase.execute()
            if result.isEmpty {
                state = .empty
            } else {
                state = .loaded(result)
            }
        } catch {
            state = .failed
        }
    }

    func refresh() async {
        do {
            let result = try await useCase.execute()
            if result.isEmpty {
                state = .empty
            } else {
                state = .loaded(result)
            }
        } catch {
            print("keep previous list")
        }
    }
}
