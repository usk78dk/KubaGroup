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

    var currentSearchedTracks: [MusicTrack]?
    var searchMessage: String?

    // MARK: - Life Cycle

    init(with musicService: MusicService) {
        self.musicService = musicService
    }

    // MARK: - Search

    func updateSearchString(_ searchString: String) async {

        let searchResult = await self.musicService.searchForTracks(searchString)
        currentSearchedTracks = searchResult.tracks
        searchMessage = searchResult.message
    }

}
