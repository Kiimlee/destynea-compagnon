//
//  HTTPError.swift
//  DestyneaCore
//
//  Created by Willy Kim on 23/11/2026.
//

public enum HTTPError: Error, Equatable {
    case badStatus(code: Int)
}
