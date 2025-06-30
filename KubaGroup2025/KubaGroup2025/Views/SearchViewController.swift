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

    // MARK: - life Cycle

    init(with viewModel: SearchViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        title = "Search"
        view.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

