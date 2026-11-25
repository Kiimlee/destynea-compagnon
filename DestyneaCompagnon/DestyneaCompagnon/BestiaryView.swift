import SwiftUI
import DestyneaCore

struct BestiaryView: View {
    @State private var viewModel: BestiaryViewModel
    @Environment(BestiaryRouter.self) private var router: BestiaryRouter

    init(viewModel: BestiaryViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.path) {
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
            List(viewModel.visibleCreatures) { creature in
                NavigationLink(value: creature) {
                    VStack(alignment: .leading) {
                        Text(creature.name)
                            .font(.headline)
                        Text(creature.type.displayName)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .accessibilityElement(children: .combine)   // un seul arrêt VoiceOver par monstre
            }
            .overlay {                                     // PAR-DESSUS la liste : la toolbar reste là pour retirer le filtre
                if let weakness = viewModel.weaknessFilter, viewModel.visibleCreatures.isEmpty {
                    ContentUnavailableView(
                        "Aucun monstre faible",
                        systemImage: "shield",
                        description: Text("Aucune créature n'est faible au type \(weakness.displayName).")
                    )
                }
            }
            .refreshable { await viewModel.refresh() }     // pull-to-refresh natif
            .navigationDestination(for: Creature.self) { creature in
                CreatureDetailView(creature: creature)
            }
            .toolbar {
                Button {
                    if let randomCreature = creatures.randomElement() {
                        router.show(randomCreature)
                    }
                } label: {
                    Label("Monstre au hasard", systemImage: "dice")
                }
                Menu {
                    Picker("Faible à", selection: $viewModel.weaknessFilter) {
                        Text("Tous").tag(DamageType?.none)            // le tag a le type EXACT de la sélection : DamageType?
                        ForEach(DamageType.allCases, id: \.self) { type in
                            Text(type.displayName).tag(Optional(type))
                        }
                    }
                } label: {
                    Label("Filtrer", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
            
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
