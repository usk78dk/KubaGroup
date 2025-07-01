//
//  iTunesMusicService.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import Foundation

protocol MusicService {
    func searchForTracks(_ searchQuery: String) async -> (tracks: [MusicTrack], message: String?)
}

final class ITunesMusicService: MusicService {

    // MARK: - Private Properties

    private let musicRepository: MusicRepository

    // MARK: - Initialization

    init(musicRepository: MusicRepository = ITunesMusicRepository()) {
        self.musicRepository = musicRepository
    }

    // MARK: - Public Methods

    func searchForTracks(_ searchQuery: String) async -> (tracks: [MusicTrack], message: String?) {
        guard searchQuery.count > 1 else { return (tracks: [], message: searchQuery.isEmpty ? "" : "Need to enter at least 2 characters") }

        do {
            let tracks = try await musicRepository.searchForTracks(searchQuery)

            return (tracks, message: tracks.count == 0 ? "No tracks found" : nil)
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                return (tracks: [], message: nil)
            }
            debugPrint(error.localizedDescription)
            return (tracks: [], message: error.localizedDescription)
        }
    }
}
