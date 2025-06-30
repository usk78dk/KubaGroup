//
//  iTunesMusicService.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

protocol MusicService {
    func searchForTracks(_ searchQuery: String) async -> [MusicTrack]
}

final class ITunesMusicService: MusicService {

    // MARK: - Private Properties

    private let musicRepository: MusicRepository

    // MARK: - Initialization

    init(musicRepository: MusicRepository = ITunesMusicRepository()) {
        self.musicRepository = musicRepository
    }

    // MARK: - Public Methods

    func searchForTracks(_ searchQuery: String) async -> [MusicTrack] {
        do {
            return try await musicRepository.searchForTracks(searchQuery)
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
}
