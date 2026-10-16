//
//  KarmaPurse.swift
//  DestyneaCore
//
//  Created by Willy Kim on 16/10/2026.
//

struct KarmaPurse {
    private var coins: [KarmaCoin] = []
    
    mutating func add(_ coin: KarmaCoin) {
        guard count(of: coin) < coin.purseLimit else { return }
        coins.append(coin)
    }
    
    func count(of coin: KarmaCoin) -> Int {
        return coins.count(where: { $0 == coin })
    }
}
