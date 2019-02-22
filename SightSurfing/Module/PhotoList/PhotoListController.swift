//
//  PhotoListController.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/9.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit

class PhotoListController: PaginationControllerProtocol {
    typealias T = PhotoListCellViewModel

    enum Configuration {
        static let photoCountPerPage = 15
        static let positionName = "japan"
    }

    private var isLoading: Bool = false

    private let service: PhotoServiceProtocol
    init(service: PhotoServiceProtocol = PhotoService()) {
        self.service = service
    }

    func start() {
        initFetchData()
    }

    private func buildCellViewModels(photos: [Photo]) -> [PhotoListCellViewModel] {
        let fromCount = container.count
        return photos
                .enumerated()
                .map { buildCellViewModel(index: $0.offset+fromCount, photo: $0.element) }
    }

    private func buildCellViewModel(index: Int, photo: Photo) -> PhotoListCellViewModel {
        return PhotoListCellViewModel(photoUrl: photo.imageUrlString, indexString: "\(index)")
    }

    // MARK: - Pagination conforming
    weak var listViewContainer: ListViewContainerProtocol?
    var perPage: Int {
        return Configuration.photoCountPerPage
    }

    var totalCount: Int = 0

    var container: [PhotoListCellViewModel] = []

    func fetchData(at offset: Int, complete: @escaping ([PhotoListCellViewModel]) -> Void) {
        if isLoading { return }
        isLoading = true
        let currentPage = Int(container.count/perPage) + 1
        service.searchPhoto(keyword: Configuration.positionName, page: currentPage, perPage: Configuration.photoCountPerPage) { [weak self] (photos, totalResults, error) in

            self?.totalCount = totalResults
            let cellViewModels = self?.buildCellViewModels(photos: photos) ?? []

            complete(cellViewModels)
            self?.isLoading = false
        }
    }

}
