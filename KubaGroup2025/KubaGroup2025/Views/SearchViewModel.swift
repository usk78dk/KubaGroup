//
//  SearchViewModel.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import Foundation

class SearchViewModel {

    // MARK: - Private Properties

    private let musicService: MusicService

    // MARK: - Public Properties

    var currentSearchResult: [MusicTrack]?

    // MARK: - Life Cycle

   init(with musicService: MusicService) {
        self.musicService = musicService
    }

    // MARK: - Search

    func updateSearchString(_ searchString: String) async {

        currentSearchResult = await self.musicService.searchForTracks(searchString)

    }
}
