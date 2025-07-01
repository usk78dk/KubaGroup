//
//  ITunesMusicRepository.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import Foundation

protocol MusicRepository {
    func searchForTracks(_ searchQuery: String) async throws -> [MusicTrack]
}

final class ITunesMusicRepository: MusicRepository {
    // MARK: - Private Properties

    private let apiUrl = "https://itunes.apple.com/"

    // MARK: - Public Methods

    func searchForTracks(_ searchQuery: String) async throws -> [MusicTrack] {

        guard let searchParm = searchQuery.lowercased().replacingOccurrences(of: " ", with: "+").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { throw "Invalid query" }

        guard var urlComponents = URLComponents(string: apiUrl + "search") else { throw URLError(.badURL) }

        let parameters: [String: String] = [
            "term": searchParm,
            "country": "DK",
            "media" : "music"
        ]

        urlComponents.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        struct searchData: Codable {
            var results: [ITunesMusicTrack]
        }

        guard let searchResult = try? JSONDecoder().decode(searchData.self, from: data) else { throw "Wrong JSON format" }

        return searchResult.results
    }

}
