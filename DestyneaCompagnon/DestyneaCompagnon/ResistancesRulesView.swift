//
//  ResistancesRulesView.swift
//  DestyneaCompagnon
//
//  Created by Willy Kim on 25/11/2026.
//

import SwiftUI

struct ResistancesRulesView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                readValueSection
                rulesSection
                damageTypeSection
            }
            .navigationTitle("Résistances")
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Text("OK")
                }
            }.presentationDetents([.medium, .large])
        }
    }

    private var readValueSection: some View {
        Section(content: {
            LabeledContent("+2", value: "−2 dégâts (résistance)")
            LabeledContent("+1", value: "−1 dégât (résistance)")
            LabeledContent("-1", value: "+1 dégât (faiblesse)")
            LabeledContent("-2", value: "+2 dégâts (faiblesse)")
            LabeledContent("Immunité", value: "Aucun dégât")
        }, footer: {
            Text("Dégâts subis = dégâts − résistance")
        })
    }
    
    private var rulesSection: some View {
        Section("Règles") {
            Text("Une attaque réussie inflige toujours au moins 1 dégât, sauf immunité")
            Text("Les résistances ne se cumulent pas : seule la plus forte s'applique")
        }
    }
    
    private var damageTypeSection: some View {
        Section("Types de dégâts") {
            LabeledContent("Physiques", value: "Contondant, Tranchant, Perforant")
            LabeledContent("Élémentaires ou non physiques", value: "Feu, Eau, Terre, Vent, Lumière, Ténèbres")
        }
    }
}
