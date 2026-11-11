import SwiftUI
import DestyneaCore

import SwiftUI
import DestyneaCore

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            BestiaryView(viewModel: makeBestiaryViewModel())
        }
    }

    private func makeBestiaryViewModel() -> BestiaryViewModel {
        let url = Bundle.main.url(forResource: "bestiary", withExtension: "json")
        let data = url.flatMap { try? Data(contentsOf: $0) } ?? Data()   // fichier absent → Data vide → état .failed
        let repository = JSONCreatureRepository(data: data)
        return BestiaryViewModel(useCase: FetchBestiaryUseCase(repository: repository))
    }
}
