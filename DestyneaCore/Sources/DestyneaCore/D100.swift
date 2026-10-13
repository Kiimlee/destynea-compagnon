//
//  D100.swift
//  DestyneaCore
//
//  Created by Willy Kim on 13/10/2026.
//

struct D100 {
    let value: Int
    
    init?(_ value: Int) {
        guard (1...100).contains(value) else { return nil }
        self.value = value
    }
}
