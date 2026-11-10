@testable import DestyneaCore

/// Faux repository qui renvoie un résultat DIFFÉRENT à chaque appel (pour tester load puis refresh).
/// C'est un `actor` : il garde un état (`results`) modifié à chaque appel, et Swift 6 exige que cet état
/// soit protégé contre les accès concurrents.
actor SequenceCreatureRepository: CreatureRepository {
    struct FetchError: Error {}

    private var results: [Result<[Creature], FetchError>]

    init(_ results: [Result<[Creature], FetchError>]) {
        self.results = results
    }

    func fetch() async throws -> [Creature] {
        try results.removeFirst().get()
    }
}
