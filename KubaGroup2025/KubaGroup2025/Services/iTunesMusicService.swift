//
//  iTunesMusicService.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

protocol BaseService {
}

final class ITunesMusicService: BaseService {

    // MARK: - Private Properties

    private let iTunesMusicRepository: BaseRepository

    // MARK: - Initialization

    init(iTunesMusicRepository: BaseRepository = ITunesMusicRepository()) {
        self.iTunesMusicRepository = iTunesMusicRepository
    }

    // MARK: - Public Methods

}
