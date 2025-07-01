//
//  ITunesMusicRepositoryMock.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 01/07/2025.
//

import Foundation

final class MockMusicRepository: MusicRepository {
    // MARK: - Public Properties

    var shouldThrowError = false
    var shouldReturnCancelledURLError = false
    var mockTracks: [MusicTrack] = []

    // MARK: - Public Methods

    func searchForTracks(_ searchQuery: String) async throws -> [MusicTrack] {
        if shouldThrowError {
            if shouldReturnCancelledURLError {
                throw URLError(.cancelled)
            } else {
                throw SearchErrorMock.generic
            }
        }
        return mockTracks
    }
}
