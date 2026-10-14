//
//  D100.swift
//  DestyneaCore
//
//  Created by Willy Kim on 13/10/2026.
//

struct D100 {
    static let range = 1...100
    let value: Int

    init?(_ value: Int) {
        guard Self.range.contains(value) else { return nil }
        self.value = value
    }
}
