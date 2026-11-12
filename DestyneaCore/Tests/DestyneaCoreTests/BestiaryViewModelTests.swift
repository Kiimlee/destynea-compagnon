//
//  BestiaryViewModelTests.swift
//  DestyneaCore
//
//  Created by Willy Kim on 10/11/2026.
//

import Testing
@testable import DestyneaCore

@MainActor
@Test func initialStateIsLoading() {
    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [])))
    #expect(viewModel.state == .loading)
}

@MainActor
@Test func loadRetrievesSortedCreatures() async {
    let squelette = Creature.fixture(name: "Squelette")
    let gobelin = Creature.fixture(name: "Gobelin")

    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [
        squelette,
        gobelin,
    ])))
    
    await viewModel.load()
    
    #expect(viewModel.state == .loaded([gobelin, squelette]))
}

@MainActor
@Test func loadReturnsAnEmptyList() async {
    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [])))
    
    await viewModel.load()
    
    #expect(viewModel.state == .empty)
}

@MainActor
@Test func repositoryReturnsAnErrorLoadFails() async {
    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: FailingCreatureRepository()))
    
    await viewModel.load()
    
    #expect(viewModel.state == .failed)
}

@MainActor
@Test func failsFirstThenSucceedOnSecondTry() async {
    let squelette = Creature.fixture(name: "Squelette")
    let repository = SequenceCreatureRepository([
        .failure(SequenceCreatureRepository.FetchError()),
        .success([squelette])
    ])
    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: repository))

    await viewModel.load()
    await viewModel.load()

    #expect(viewModel.state == .loaded([squelette]))     // l'ancienne liste est toujours là
}


@MainActor
@Test func successfulRefreshShowsNewList() async {
    let squelette = Creature.fixture(name: "Squelette")
    let gobelin = Creature.fixture(name: "Gobelin")
    
    let repository = SequenceCreatureRepository([
        .success([squelette]),
        .success([gobelin])
    ])
    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: repository))

    await viewModel.load()
    await viewModel.refresh()

    #expect(viewModel.state == .loaded([gobelin]))     // l'ancienne liste est toujours là
}


@MainActor
@Test func failedRefreshKeepsPreviousList() async {
    let squelette = Creature.fixture(name: "Squelette")
    let repository = SequenceCreatureRepository([
        .success([squelette]),                       // 1er appel : load() réussit
        .failure(SequenceCreatureRepository.FetchError())   // 2e appel : refresh() échoue
    ])
    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: repository))

    await viewModel.load()
    await viewModel.refresh()

    #expect(viewModel.state == .loaded([squelette]))     // l'ancienne liste est toujours là
}
