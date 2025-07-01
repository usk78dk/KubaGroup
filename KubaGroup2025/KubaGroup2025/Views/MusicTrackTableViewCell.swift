//
//  MusicTrackTableViewCell.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import UIKit

class MusicTrackTableViewCell: UITableViewCell {

    static let cellIdentifier = "MusicTrackCell"

    // MARK: - UI Properties

    let coverArtImageView: AsyncSetImageView = {
        let coverArtImageView = AsyncSetImageView()
        coverArtImageView.translatesAutoresizingMaskIntoConstraints = false
        coverArtImageView.contentMode = .scaleAspectFit
        return coverArtImageView
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = titleLabel.font.withSize(16)
        titleLabel.lineBreakMode = .byTruncatingTail
        return titleLabel
    }()

    let artistLabel: UILabel = {
        let artistLabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.textColor = .black
        artistLabel.font = artistLabel.font.withSize(14)
        artistLabel.lineBreakMode = .byTruncatingTail
        return artistLabel
    }()

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // Due to async updates, this reset is important, so the user doesn't see old image
        coverArtImageView.reset()
    }

    // MARK: UI Setup

    private func setupUI() {
        contentView.addSubview(coverArtImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(artistLabel)
    }

    private func setupConstraints(){
        // Because of iOS' lruntime layout, we need to lower this constraint to awoid flotting the output with breakin constraints.
        let coverArtHeight = coverArtImageView.heightAnchor.constraint(equalToConstant: 60)
        coverArtHeight.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            coverArtImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            coverArtImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            coverArtImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            coverArtImageView.widthAnchor.constraint(equalTo: coverArtImageView.heightAnchor),
            coverArtHeight,

            titleLabel.leadingAnchor.constraint(equalTo: coverArtImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: coverArtImageView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8),

            artistLabel.bottomAnchor.constraint(equalTo: coverArtImageView.bottomAnchor, constant: -8),
            artistLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -8)
        ])
    }
    // MARK: - View Setup

    func configure(with musicTrack: MusicTrack) {
        artistLabel.text = musicTrack.artistName
        titleLabel.text = musicTrack.title
        Task {
            await coverArtImageView.setImage(with: musicTrack.artworkUrl)
        }
    }
}
