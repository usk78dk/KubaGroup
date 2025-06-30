//
//  AppCoordinator.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import UIKit

class AppCoordinator {

    // MARK: - Properties

    private let navigationController: UINavigationController
    private let musicService: MusicService

    // MARK: - Initialization

    init(navigationController: UINavigationController, musicService: MusicService) {
        self.navigationController = navigationController
        self.musicService = musicService
    }

    // MARK: - Navigation

    func musicTrackSelected(musicTrack: MusicTrack) {
        // Navigation, playback etc. would be controlled here.
    }

}
