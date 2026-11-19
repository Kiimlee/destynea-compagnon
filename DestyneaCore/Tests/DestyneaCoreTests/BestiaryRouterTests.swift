//
//  BestiaryRouterTests.swift
//  DestyneaCore
//

import Testing
@testable import DestyneaCore

@MainActor
@Test func routerStartsAtRoot() {
    let router = BestiaryRouter()
    #expect(router.path.isEmpty)
}

@MainActor
@Test func showingCreaturePushesIt() {
    let router = BestiaryRouter()
    let kraken = Creature.fixture(name: "Kraken", type: .boss)

    router.show(kraken)

    #expect(router.path == [kraken])
}

@MainActor
@Test func showingSeveralCreaturesStacksThemInOrder() {
    let router = BestiaryRouter()
    let goblin = Creature.fixture(name: "Gobelin")
    let kraken = Creature.fixture(name: "Kraken", type: .boss)

    router.show(goblin)
    router.show(kraken)

    #expect(router.path == [goblin, kraken])
}

@MainActor
@Test func popToRootEmptiesThePath() {
    let router = BestiaryRouter()
    router.show(Creature.fixture(name: "Gobelin"))
    router.show(Creature.fixture(name: "Kraken", type: .boss))

    router.popToRoot()

    #expect(router.path.isEmpty)
}
