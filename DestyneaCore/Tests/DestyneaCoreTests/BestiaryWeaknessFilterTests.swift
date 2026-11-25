//
//  BestiaryWeaknessFilterTests.swift
//  DestyneaCore
//

import Testing
@testable import DestyneaCore

private let goblin = Creature.fixture(name: "Gobelin", resistances: [.fire: -1])
private let skeleton = Creature.fixture(name: "Squelette", resistances: [.fire: 1])
private let kraken = Creature.fixture(name: "Kraken", type: .boss, resistances: [.fire: -2])

@MainActor
private func loadedViewModel() async -> BestiaryViewModel {
    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [kraken, skeleton, goblin])))
    await viewModel.load()
    return viewModel
}

@MainActor
@Test func withoutFilterAllCreaturesAreVisible() async {
    let viewModel = await loadedViewModel()

    #expect(viewModel.weaknessFilter == nil)
    #expect(viewModel.visibleCreatures == [goblin, skeleton, kraken])
}

@MainActor
@Test func weaknessFilterKeepsOnlyWeakCreaturesInOrder() async {
    let viewModel = await loadedViewModel()

    viewModel.weaknessFilter = .fire

    #expect(viewModel.visibleCreatures == [goblin, kraken])
}

@MainActor
@Test func removingFilterShowsAllCreaturesAgain() async {
    let viewModel = await loadedViewModel()
    viewModel.weaknessFilter = .fire

    viewModel.weaknessFilter = nil

    #expect(viewModel.visibleCreatures == [goblin, skeleton, kraken])
}

@MainActor
@Test func filterWithNoMatchGivesNoVisibleCreature() async {
    let viewModel = await loadedViewModel()

    viewModel.weaknessFilter = .light

    #expect(viewModel.visibleCreatures.isEmpty)
}

@MainActor
@Test func visibleCreaturesAreEmptyWhileNotLoaded() {
    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [goblin])))

    #expect(viewModel.visibleCreatures.isEmpty)
}

@MainActor
@Test func refreshKeepsTheFilter() async {
    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: RefreshableStubRepository(fetched: [goblin], refreshed: [goblin, skeleton, kraken])))
    await viewModel.load()
    viewModel.weaknessFilter = .fire

    await viewModel.refresh()

    #expect(viewModel.visibleCreatures == [goblin, kraken])
}
