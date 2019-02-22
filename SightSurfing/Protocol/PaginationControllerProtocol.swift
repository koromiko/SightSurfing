//
//  PaginationControllerProtocol.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/22.
//  Copyright © 2019 STH. All rights reserved.
//

import Foundation
import ObjectiveC

protocol PaginationControllerProtocol: AnyObject {
    /// The data type for the element of the list
    associatedtype T

    /// Complete closure for notifying the pagination controller to append the data
    typealias CompleteClosure = ([T]) -> Void

    // MARK: Required methods

    /// Number of data for a page
    var perPage: Int { get }

    /// Total number of data
    var totalCount: Int { get }

    /// Implement this function to fetch the data from server based on the offset information
    func fetchData(at offset: Int, complete: @escaping CompleteClosure)

    /// The view component for showing the data in tableview, collectionview, or customized view such as carousel, etc
    var listViewContainer: ListViewContainerProtocol? { get }

    /// The data containers
    var container: [T] { get set }

    // MARK: Pre-implemented methods

    /// Call this in tableView'delegate such as cellWillDisplay, to trigger the logic of pagination controller
    func willScrollTo(index: Int)

    /// Call this for the first fetch
    func initFetchData()
}

extension PaginationControllerProtocol {
    func initFetchData() {
        willScrollTo(index: 0)
    }

    func willScrollTo(index: Int) {
        // User scrolls to the last item and more items are needed to be fetched
        if (index == container.count - 1 && container.count < totalCount) || container.count == 0 {
            listViewContainer?.setupLoading(true)
            fetchData(at: container.count, complete: { [weak self] values  in
                guard let strongSelf = self else { return }

                let fromCount = strongSelf.container.count
                strongSelf.container.append(contentsOf: values)
                let toCount = strongSelf.container.count

                let indicesToBeInserted = Array(fromCount..<toCount)
                strongSelf.listViewContainer?.setupLoading(false)
                strongSelf.listViewContainer?.insert(at: indicesToBeInserted)
            })
        }
    }
}
