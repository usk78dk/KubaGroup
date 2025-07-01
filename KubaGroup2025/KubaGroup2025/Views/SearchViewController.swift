//
//  SearchViewController.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Private Properties

    private let viewModel: SearchViewModel
    private var searchTask: Task<Void, Never>?

    // MARK: - UI Components

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search track"
        return searchBar
    }()

    let labelCenterView: UIView = {
        let labelCenterView = UIView()
        labelCenterView.translatesAutoresizingMaskIntoConstraints = false
        return labelCenterView
    }()

    let searchStatusLabel: UILabel = {
        let searchStatusLabel = UILabel()
        searchStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        searchStatusLabel.textAlignment = .center
        searchStatusLabel.numberOfLines = 0
        searchStatusLabel.lineBreakMode = .byWordWrapping
        return searchStatusLabel
    }()

    let musicTrackTableView: UITableView = {
        let musicTrackTableView = UITableView()
        musicTrackTableView.translatesAutoresizingMaskIntoConstraints = false
        musicTrackTableView.register(MusicTrackTableViewCell.self, forCellReuseIdentifier: MusicTrackTableViewCell.cellIdentifier)
        return musicTrackTableView
    }()

    // MARK: - life Cycle

    init(with viewModel: SearchViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupUI()
        setupConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI

    private func setupUI() {
        title = "Search"
        view.backgroundColor = .white

        searchBar.delegate = self
        view.addSubview(searchBar)

        view.addSubview(labelCenterView)
        labelCenterView.addSubview(searchStatusLabel)

        musicTrackTableView.dataSource = self
        musicTrackTableView.delegate = self
        view.addSubview(musicTrackTableView)
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),

            labelCenterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            labelCenterView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            labelCenterView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            labelCenterView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),

            searchStatusLabel.bottomAnchor.constraint(equalTo: labelCenterView.bottomAnchor),
            searchStatusLabel.leftAnchor.constraint(equalTo: labelCenterView.leftAnchor),
            searchStatusLabel.rightAnchor.constraint(equalTo: labelCenterView.rightAnchor),
            searchStatusLabel.topAnchor.constraint(equalTo: labelCenterView.topAnchor),

            musicTrackTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            musicTrackTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            musicTrackTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            musicTrackTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
        ])
    }

}

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTask?.cancel()
        searchStatusLabel.text = "Searching..."
        labelCenterView.isHidden = false
        musicTrackTableView.isHidden = true

        viewModel.searchMessage = nil

        searchTask = Task {
            try? await Task.sleep(nanoseconds: 200_000_000)

            guard !Task.isCancelled else { return }

            await viewModel.updateSearchString(searchText)

            guard !Task.isCancelled else { return }

            await MainActor.run {
                if let searchMessage = viewModel.searchMessage {
                    searchStatusLabel.text = searchMessage
                } else {
                    self.musicTrackTableView.reloadData()
                }
                self.musicTrackTableView.isHidden = viewModel.searchMessage != nil
                self.labelCenterView.isHidden = viewModel.searchMessage == nil
            }
        }

    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentSearchedTracks?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicTrackTableViewCell.cellIdentifier, for: indexPath) as? MusicTrackTableViewCell,
              (viewModel.currentSearchedTracks?.indices.contains(indexPath.row)) != nil,
              let musicTrack = viewModel.currentSearchedTracks?[indexPath.row]
            else
        {
            return UITableViewCell()
        }

        cell.configure(with: musicTrack)

        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let musicTracks = viewModel.currentSearchedTracks,
              musicTracks.indices.contains(indexPath.row)
                else
        {
            return
        }

        AppDelegate.shared.appCoordinator?.musicTrackSelected(musicTrack: musicTracks[indexPath.row])

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

