//
//  BestiarySortAndRankFilterTests.swift
//  DestyneaCore
//

import Testing
@testable import DestyneaCore

private let goblin = Creature.fixture(name: "Gobelin", type: .minion, resistances: [.fire: -1])
private let skeleton = Creature.fixture(name: "Squelette", type: .minion, resistances: [.fire: 1, .light: -2])
private let elemental = Creature.fixture(name: "Élémentaire de feu", type: .elite)
private let kraken = Creature.fixture(name: "Kraken", type: .boss, resistances: [.fire: -2, .light: -1])

@MainActor
private func loadedViewModel() async -> BestiaryViewModel {
    let viewModel = BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: StubCreatureRepository(creatures: [kraken, skeleton, elemental, goblin])))
    await viewModel.load()
    return viewModel
}

// MARK: - Filtre par rang

@MainActor
@Test func rankFilterKeepsOnlyThatRank() async {
    let viewModel = await loadedViewModel()

    viewModel.rankFilter = .minion

    #expect(viewModel.visibleCreatures == [goblin, skeleton])
}

@MainActor
@Test func rankAndWeaknessFiltersCombine() async {
    let viewModel = await loadedViewModel()

    viewModel.rankFilter = .minion
    viewModel.weaknessFilter = .fire

    #expect(viewModel.visibleCreatures == [goblin])
}

// MARK: - Tri

@MainActor
@Test func defaultSortIsByName() async {
    let viewModel = await loadedViewModel()

    #expect(viewModel.sortOrder == .byName)
    #expect(viewModel.visibleCreatures == [elemental, goblin, kraken, skeleton])   // l'accent d'« Élémentaire » est bien géré
}

@MainActor
@Test func sortByRankFollowsRankThenName() async {
    let viewModel = await loadedViewModel()

    viewModel.sortOrder = .byRank

    #expect(viewModel.visibleCreatures == [goblin, skeleton, elemental, kraken])
}

@MainActor
@Test func sortAppliesToFilteredCreatures() async {
    let viewModel = await loadedViewModel()

    viewModel.weaknessFilter = .light
    viewModel.sortOrder = .byRank

    #expect(viewModel.visibleCreatures == [skeleton, kraken])   // par nom ce serait [kraken, skeleton]
}

// MARK: - Sections

@MainActor
@Test func sortByNameGivesOneSectionWithoutHeader() async {
    let viewModel = await loadedViewModel()

    #expect(viewModel.sections == [BestiarySection(rank: nil, creatures: [elemental, goblin, kraken, skeleton])])
}

@MainActor
@Test func sortByRankGivesOneSectionPerNonEmptyRank() async {
    let viewModel = await loadedViewModel()

    viewModel.sortOrder = .byRank

    #expect(viewModel.sections == [                         // pas de section Fantassins : aucun monstre
        BestiarySection(rank: .minion, creatures: [goblin, skeleton]),
        BestiarySection(rank: .elite, creatures: [elemental]),
        BestiarySection(rank: .boss, creatures: [kraken]),
    ])
}

@MainActor
@Test func noVisibleCreatureGivesNoSection() async {
    let viewModel = await loadedViewModel()

    viewModel.weaknessFilter = .earth

    #expect(viewModel.sections.isEmpty)
}

// MARK: - Réinitialiser

@MainActor
@Test func resetFiltersClearsBothFilters() async {
    let viewModel = await loadedViewModel()
    viewModel.rankFilter = .minion
    viewModel.weaknessFilter = .fire

    viewModel.resetFilters()

    #expect(!viewModel.hasActiveFilter)
    #expect(viewModel.visibleCreatures == [elemental, goblin, kraken, skeleton])
}
