//
//  KarmaPurse.swift
//  DestyneaCore
//
//  Created by Willy Kim on 16/10/2026.
//

struct KarmaPurse {
    private var coins: [KarmaCoin] = []
    
    mutating func add(_ coin: KarmaCoin) {
        coins.append(coin)
    }
    
    func count(of coin: KarmaCoin) -> Int {
        return coins.filter { $0 == coin }.count
    }
}
