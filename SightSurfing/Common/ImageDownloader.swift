//
//  ImageDownloader.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/19.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit

class CacheManager {
    private let fileManager: FileManager
    private var tempPath: URL? {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }

    func saveCache(data: Data, urlString: String) {
        guard var fileUrl = tempPath else { return }
        fileUrl.appendPathComponent(filename(from: urlString))
        try? data.write(to: fileUrl)
    }

    func cache(of urlString: String) -> Data? {
        guard var fileUrl = tempPath else { return nil }
        fileUrl.appendPathComponent(filename(from: urlString))
        return try? Data(contentsOf: fileUrl)
    }

    private func filename(from urlString: String) -> String {
        guard let url = URL(string: urlString) else { return "invalid" }
        return url.lastPathComponent
    }
}

class ImageDownloader {
    static let shared: ImageDownloader = ImageDownloader()

    private var mappingTable: [Int: String] = [:]

    private let cacheManager: CacheManager
    private let session: URLSession
    init(session: URLSession = URLSession.shared, cacheManager: CacheManager = CacheManager()) {
        self.session = session
        self.cacheManager = cacheManager
    }

    func setupImage(to imageView: UIImageView, with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if let data = cacheManager.cache(of: urlString) {
            imageView.image = UIImage(data: data)
        } else {
            mappingTable[objectIdentifier(imageView: imageView)] = urlString
            session.downloadTask(with: url) { [weak self] (location, response, error) in
                if let location = location, let data = try? Data(contentsOf: location) {

                    // Check if the downloaded image is needed or the image view has been reused
                    if let key = self?.objectIdentifier(imageView: imageView),
                        let requestUrlString = response?.url?.absoluteString, self?.mappingTable[key] == requestUrlString {
                        DispatchQueue.main.async {
                            imageView.image = UIImage(data: data)
                        }
                        self?.mappingTable.removeValue(forKey: key)
                    }

                    self?.cacheManager.saveCache(data: data, urlString: urlString)
                }
            }.resume()
        }
    }

    func objectIdentifier(imageView: UIImageView) -> Int {
        return ObjectIdentifier(imageView).hashValue
    }
}

extension UIImageView {
    private var imageDownloader: ImageDownloader {
        return ImageDownloader.shared
    }

    func setupImage(with urlString: String) {
        imageDownloader.setupImage(to: self, with: urlString)
    }
}
