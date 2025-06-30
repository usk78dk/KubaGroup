//
//  ITunesMusicTrack.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import Foundation

struct ITunesMusicTrack: MusicTrack, Codable {

    let artistName: String
    let artworkUrl: URL
    let description: String
    let releaseYear: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case artistName
        case artworkUrl = "artworkUrl60"
        case description = "collectionName"
        case releaseYear = "releaseDate"
        case title = "trackName"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        artistName = try container.decodeIfPresent(String.self, forKey: .artistName)!
        artworkUrl = try container.decodeIfPresent(URL.self, forKey: .artworkUrl)!
        description = try container.decodeIfPresent(String.self, forKey: .description)!
//        releaseDate = try container.decodeIfPresent(Date.self, forKey: .releaseDate)!
        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseYear) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            releaseYear = String(Calendar.current.component(.year, from: dateFormatter.date(from: releaseDateString)!))
        } else {
            throw "Error finding release date"
        }
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""

//        imageURLs = try? container.decode([String].self, forKey: CodingKeys.imageUrl)
//        if imageURLs == nil, let imageUrl = try? container.decode(String.self, forKey: .imageUrl) {
//            self.imageURLs = [imageUrl]
//        }
    }

}
