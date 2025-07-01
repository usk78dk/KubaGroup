//
//  iTunesMusicServiceTests.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 01/07/2025.
//

import XCTest
@testable import KubaGroup2025

class iTunesMusicServiceTests: XCTestCase {
    func test_searchForTracks_successWithResults() async {
        let mockRepo = MockMusicRepository()
        mockRepo.mockTracks = [
            MusicTrackMock(
                artistName: "Guns N' Roses",
                artworkUrl: "https://example.com/art.jpg",
                description: "Appetite For Destruction",
                releaseDate: "1987-07-21",
                title: "Nightrain"
            )
        ]

        let service = ITunesMusicService(musicRepository: mockRepo)
        let result = await service.searchForTracks("Guns")

        XCTAssertEqual(result.tracks.count, 1)
        XCTAssertNil(result.message)
    }

    func test_searchForTracks_successWithNoResults() async {
        let mockRepo = MockMusicRepository()
        mockRepo.mockTracks = []
        let service = ITunesMusicService(musicRepository: mockRepo)

        let result = await service.searchForTracks("UnknownArtist")
        XCTAssertEqual(result.tracks.count, 0)
        XCTAssertEqual(result.message, "No tracks found")
    }

    func test_searchForTracks_error_generic() async {
        let mockRepo = MockMusicRepository()
        mockRepo.shouldThrowError = true
        let service = ITunesMusicService(musicRepository: mockRepo)

        let result = await service.searchForTracks("Fail")
        XCTAssertEqual(result.tracks.count, 0)
        XCTAssertEqual(result.message, SearchErrorMock.generic.localizedDescription)
    }

    func test_searchForTracks_error_cancelled() async {
        let mockRepo = MockMusicRepository()
        mockRepo.shouldThrowError = true
        mockRepo.shouldReturnCancelledURLError = true
        let service = ITunesMusicService(musicRepository: mockRepo)

        let result = await service.searchForTracks("Cancelled")
        XCTAssertEqual(result.tracks.count, 0)
        XCTAssertNil(result.message)
    }

    func test_searchForTracks_shortQuery_singleChar() async {
        let service = ITunesMusicService(musicRepository: MockMusicRepository())
        let result = await service.searchForTracks("A")

        XCTAssertEqual(result.tracks.count, 0)
        XCTAssertEqual(result.message, "Need to enter at least 2 characters")
    }

    func test_searchForTracks_emptyQuery() async {
        let service = ITunesMusicService(musicRepository: MockMusicRepository())
        let result = await service.searchForTracks("")

        XCTAssertEqual(result.tracks.count, 0)
        XCTAssertEqual(result.message, "")
    }
}
