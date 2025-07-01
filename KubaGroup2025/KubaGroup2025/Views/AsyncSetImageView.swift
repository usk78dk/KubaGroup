//
//  AsyncSetImageView.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 01/07/2025.
//

import UIKit

class AsyncSetImageView: UIImageView {

    // MARK: - Private Properties

    private var imageUrlString: String?
    private var loadTask: Task<Void, Never>?

    // MARK: - Public Functions

    func setImage(with urlString: String) async {
        self.imageUrlString = urlString

        loadTask = Task.detached {
            do {
                guard let imageUrl = URL(string: urlString) else { throw URLError(.badURL) }
                let data = try Data(contentsOf: imageUrl)
                guard !Task.isCancelled else  { return }
                if let image = UIImage(data: data) {
                    await self.setImage(image, forUrlString: urlString)
                } else {
                    throw "Image Data Error"
                }
            } catch {
                await self.setImage(UIImage(named: "imageBrokenIcon"), forUrlString: urlString)
            }
        }
    }

    func reset() {
        self.loadTask?.cancel()
        self.imageUrlString = nil
        self.image = nil
    }
    
    // MARK: - Private Functions

    private func setImage(_ image: UIImage?, forUrlString: String) async {
        guard let currentUrlString = imageUrlString,
              currentUrlString == forUrlString
        else {
            return
        }

        await MainActor.run {
            self.image = image
        }
    }

}

