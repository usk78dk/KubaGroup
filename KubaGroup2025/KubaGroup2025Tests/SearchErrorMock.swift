//
//  SearchErrorMock.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 01/07/2025.
//

import Foundation

enum SearchErrorMock: LocalizedError {
    case generic

    var errorDescription: String? {
        // Could be expanded with more specific error types - this is just for demo purposes
        switch self {
        case .generic: return "Something went wrong"
        }
    }
}
