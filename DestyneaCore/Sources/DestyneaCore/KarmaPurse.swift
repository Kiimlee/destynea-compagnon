//
//  KarmaPurse.swift
//  DestyneaCore
//
//  Created by Willy Kim on 16/10/2026.
//

enum KarmaPurseError: Error, Equatable {
    case coinNotOwned(KarmaCoin)
}

struct KarmaPurse {
    private var coins: [KarmaCoin] = []
    
    mutating func add(_ coin: KarmaCoin) {
        guard count(of: coin) < coin.purseLimit else { return }
        coins.append(coin)
    }
    
    mutating func spend(_ requested: [KarmaCoin]) throws -> Int {
        var remaining = coins
        var total = 0

        for coin in requested {
            guard let index = remaining.firstIndex(of: coin) else { throw KarmaPurseError.coinNotOwned(coin) }
            remaining.remove(at: index)
            total += coin.bonus
        }

        coins = remaining
        return total
    }
    
    mutating func loseUnusedCoins() {
        coins.removeAll()
    }
    
    func count(of coin: KarmaCoin) -> Int {
        return coins.count(where: { $0 == coin })
    }
}
