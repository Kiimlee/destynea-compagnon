import SwiftUI
import DestyneaCore

struct BestiaryView: View {
    @State private var viewModel: BestiaryViewModel

    init(viewModel: BestiaryViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

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
                    Text(creature.type.displayName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .accessibilityElement(children: .combine)   // un seul arrêt VoiceOver par monstre
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
