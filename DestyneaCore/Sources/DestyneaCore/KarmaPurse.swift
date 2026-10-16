//
//  KarmaPurse.swift
//  DestyneaCore
//
//  Created by Willy Kim on 16/10/2026.
//

struct KarmaPurse {
    private var coins: [KarmaCoin] = []
    
    mutating func add(_ coin: KarmaCoin) {
        switch coin {
        case .copper:
            guard count(of: coin) < 3 else { return }
            coins.append(coin)
        case .silver:
            guard count(of: coin) < 2 else { return }
            coins.append(coin)
        case .gold:
            guard count(of: coin) < 1 else { return }
            coins.append(coin)
        }
    }
    
    func count(of coin: KarmaCoin) -> Int {
        return coins.count(where: { $0 == coin })
    }
}
