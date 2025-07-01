//
//  ITunesMusicTrack.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import Foundation

struct ITunesMusicTrack: MusicTrack, Codable {

    let artistName: String
    let artworkUrl: String
    let description: String
    let releaseDate: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case artistName
        case artworkUrl = "artworkUrl60"
        case description = "collectionName"
        case releaseDate
        case title = "trackName"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        artistName = try container.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        artworkUrl = try container.decodeIfPresent(String.self, forKey: .artworkUrl) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            let iTunesdateFormatter = DateFormatter()
            iTunesdateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            iTunesdateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            releaseDate = dateFormatter.string(from: iTunesdateFormatter.date(from: releaseDateString)!)
        } else {
            releaseDate = "Unknown"
        }
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    }

}
