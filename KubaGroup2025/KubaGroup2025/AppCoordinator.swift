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
    private let iTunesMusicService: BaseService

    // MARK: - Initialization

    init(navigationController: UINavigationController, iTunesMusicService: BaseService) {
        self.navigationController = navigationController
        self.iTunesMusicService = iTunesMusicService
    }

    // MARK: - Navigation

    func musicTrackSelected(musicTrack: MusicTrack) {
        // Navigation etc. would be controlled here.
    }

}
