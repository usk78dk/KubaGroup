//
//  SearchViewModel.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import Foundation

class SearchViewModel {

    // MARK: - Private Properties

    private let iTunesMusicService: BaseService

    // MARK: - Public Properties

    var currentSearchResult: [MusicTrack]?

    // MARK: - Life Cycle

   init(with iTunesMusicService: ITunesMusicService) {
        self.iTunesMusicService = iTunesMusicService
    }

    // MARK: - Search

    func updateSearchString(_ searchString: String) {

    }
}
