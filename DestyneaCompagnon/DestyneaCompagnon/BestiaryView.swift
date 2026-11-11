import SwiftUI
import DestyneaCore

struct BestiaryView: View {
    @State var viewModel: BestiaryViewModel
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Bestiaire")
        }
        .task { await viewModel.load() }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Chargement du bestiaire…")
            
        case .loaded(let creatures):                       // la liste n'existe QUE dans cet état
            List(creatures) { creature in
                VStack(alignment: .leading) {
                    Text(creature.name)
                        .font(.headline)
                    Text(creature.type.displayName)                // ex. « minion » (on traduira plus tard)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .refreshable { await viewModel.refresh() }     // pull-to-refresh natif
            
        case .empty:
            ContentUnavailableView("Bestiaire vide", systemImage: "book.closed")
            
        case .failed:
            ContentUnavailableView {
                Label("Impossible de charger le bestiaire", systemImage: "exclamationmark.triangle")
            } actions: {
                Button("Réessayer") {
                    Task { await viewModel.load() }        // ← l'action d'un Button n'est PAS async : le pont !
                }
            }
        }
    }
}
