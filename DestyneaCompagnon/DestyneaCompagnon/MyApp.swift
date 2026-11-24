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
        let repository = CachedCreatureRepository(repository: remote)   // le décorateur enveloppe le réseau
        return BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: repository))
    }
}
