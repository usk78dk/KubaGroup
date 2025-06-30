//
//  String+extension.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
