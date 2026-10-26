@testable import DestyneaCore

/// Faux repository qui renvoie la liste qu'on lui donne (le « dé pipé » du bestiaire).
struct StubCreatureRepository: CreatureRepository {
    let creatures: [Creature]

    func fetch() async throws -> [Creature] {
        creatures
    }
}

/// Faux repository qui échoue toujours, pour tester la propagation d'erreur.
struct FailingCreatureRepository: CreatureRepository {
    struct FetchError: Error, Equatable {}

    func fetch() async throws -> [Creature] {
        throw FetchError()
    }
}
