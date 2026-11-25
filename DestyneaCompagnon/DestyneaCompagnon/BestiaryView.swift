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
            
        case .loaded:
            List {
                ForEach(viewModel.sections) { section in
                    Section {
                        ForEach(section.creatures) { creature in
                            row(for: creature)
                        }
                    } header: {
                        if let rank = section.rank {       // en-tête seulement en tri par rang
                            Text(rank.pluralDisplayName)
                        }
                    }
                }
            }
            .overlay {                                     // PAR-DESSUS la liste : la toolbar reste là pour retirer les filtres
                if viewModel.hasActiveFilter, viewModel.visibleCreatures.isEmpty {
                    ContentUnavailableView {
                        Label("Aucun monstre ne correspond", systemImage: "line.3.horizontal.decrease.circle")
                    } description: {
                        Text("Essaie un autre rang ou une autre faiblesse.")
                    } actions: {
                        Button("Réinitialiser les filtres") { viewModel.resetFilters() }
                    }
                }
            }
            .refreshable { await viewModel.refresh() }     // pull-to-refresh natif
            .navigationDestination(for: Creature.self) { creature in
                CreatureDetailView(creature: creature)
            }
            .toolbar {
                Button {
                    if let randomCreature = viewModel.visibleCreatures.randomElement() {   // PO : pioche dans la liste VISIBLE
                        router.show(randomCreature)
                    }
                } label: {
                    Label("Monstre au hasard", systemImage: "dice")
                }
                filterMenu
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

    private func row(for creature: Creature) -> some View {
        NavigationLink(value: creature) {
            VStack(alignment: .leading) {
                Text(creature.name)
                    .font(.headline)
                if viewModel.sortOrder == .byName {        // en tri par rang, la section affiche déjà le rang
                    Text(creature.type.displayName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .accessibilityElement(children: .combine)           // un seul arrêt VoiceOver par monstre
    }

    /// Un seul bouton dans la toolbar, 3 sous-menus : trier, filtrer par rang, filtrer par faiblesse.
    private var filterMenu: some View {
        Menu {
            Picker("Trier par", selection: $viewModel.sortOrder) {
                ForEach(BestiarySortOrder.allCases, id: \.self) { order in
                    Text(order.displayName).tag(order)
                }
            }
            .pickerStyle(.menu)

            Picker("Rang", selection: $viewModel.rankFilter) {
                Text("Tous").tag(CreatureType?.none)        // le tag a le type EXACT de la sélection : CreatureType?
                ForEach(CreatureType.allCases, id: \.self) { rank in
                    Text(rank.pluralDisplayName).tag(Optional(rank))
                }
            }
            .pickerStyle(.menu)

            Picker("Faible à", selection: $viewModel.weaknessFilter) {
                Text("Tous").tag(DamageType?.none)
                ForEach(DamageType.allCases, id: \.self) { type in
                    Text(type.displayName).tag(Optional(type))
                }
            }
            .pickerStyle(.menu)
        } label: {
            Label("Trier et filtrer", systemImage: "line.3.horizontal.decrease.circle")
        }
    }
}
