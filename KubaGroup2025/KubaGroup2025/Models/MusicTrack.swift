//
//  MusicTrack.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import Foundation

protocol MusicTrack {
    var artistName: String { get }
    var artworkUrl: String { get }
    var description: String { get }
    var releaseDate: String { get }
    var title: String { get }
}
