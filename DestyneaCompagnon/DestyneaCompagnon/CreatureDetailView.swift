//
//  CreatureDetailView.swift
//  DestyneaCompagnon
//
//  Created by Willy Kim on 16/11/2026.
//

import SwiftUI
import DestyneaCore

struct CreatureDetailView: View {
    @State private var resistancesSheetIsShown: Bool = false
    let creature: Creature
    
    var body: some View {
        Form {
            statsSection
            resistancesSection
            descriptionSection
        }
        .navigationTitle(creature.name)
        .sheet(isPresented: $resistancesSheetIsShown) {
            ResistancesRulesView()
        }
    }
    
    private var statsSection: some View {
        Section("Statistiques") {
            LabeledContent("Rang", value: creature.type.displayName)
            LabeledContent("PdV", value: creature.hitPoints.displayText)
                .accessibilityLabel("Points de vie, \(creature.hitPoints.displayText)")
            LabeledContent("Taux de réussite", value: creature.successRate.displayText)
            LabeledContent("PM", value: "\(creature.movementPoints)")
                .accessibilityLabel("Points de mouvement, \(creature.movementPoints)")
            LabeledContent("Initiative", value: "\(creature.initiative)")
        }
    }
    
    private var resistancesSection: some View {
        Section(content: {
            Text(creature.resistances.displayText)
        }, header: {
            Button("Résistances", systemImage: "info.circle", action: {
                resistancesSheetIsShown = true
            })
        })
    }
    
    private var descriptionSection: some View {
        Section("Description") {
            Text(creature.description)
        }
    }
}

#Preview {
    NavigationStack {
        CreatureDetailView(creature: Creature(
            name: "Squelette",
            type: .minion,
            origin: .undead,
            size: .m,
            hitPoints: 4...6,
            movementPoints: 5,
            successRate: 45...55,
            resistances: [.piercing: 1, .bludgeoning: -2, .darkness: 1, .light: -2],
            initiative: 0,
            description: "Des os blanchis qui cliquettent dans le silence."
        ))
    }
}
