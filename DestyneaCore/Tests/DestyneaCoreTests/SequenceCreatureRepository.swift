@testable import DestyneaCore

/// Faux repository qui renvoie un résultat DIFFÉRENT à chaque appel (pour tester load puis refresh).
/// Il compte aussi ses appels (`fetchCount`) pour qu'un test vérifie qu'on ne l'a PAS rappelé (cache).
/// C'est un `actor` : il garde un état (`results`, `fetchCount`) modifié à chaque appel, et Swift 6 exige
/// que cet état soit protégé contre les accès concurrents.
actor SequenceCreatureRepository: CreatureRepository {
    struct FetchError: Error {}

    private var results: [Result<[Creature], FetchError>]
    private(set) var fetchCount = 0

    init(_ results: [Result<[Creature], FetchError>]) {
        self.results = results
    }

    func fetch() async throws -> [Creature] {
        fetchCount += 1
        return try results.removeFirst().get()
    }
}
