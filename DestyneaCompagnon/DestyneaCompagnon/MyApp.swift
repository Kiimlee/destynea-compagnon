import SwiftUI
import DestyneaCore


@main
struct MyApp: App {
    @State private var router = BestiaryRouter()

    var body: some Scene {
        WindowGroup {
            BestiaryView(viewModel: makeBestiaryViewModel())
                .environment(router)
        }
    }

    private func makeBestiaryViewModel() -> BestiaryViewModel {
        let url = URL(string: "https://raw.githubusercontent.com/Kiimlee/destynea-compagnon/main/DestyneaCompagnon/DestyneaCompagnon/bestiary.json")!
        let remote = RemoteCreatureRepository(url: url, client: URLSession.shared)
        let bundled = JSONCreatureRepository(data: bundledBestiaryData())
        let offlineTolerant = FallbackCreatureRepository(primary: remote, fallback: bundled)
        let repository = CachedCreatureRepository(repository: offlineTolerant)   // le cache enveloppe TOUT (voir l'ordre)
        return BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: repository))
    }

    /// Le bestiaire embarqué dans l'app : la copie de secours quand le réseau est indisponible.
    private func bundledBestiaryData() -> Data {
        let url = Bundle.main.url(forResource: "bestiary", withExtension: "json")
        return url.flatMap { try? Data(contentsOf: $0) } ?? Data()   // fichier absent → Data vide → état .failed
    }
}
