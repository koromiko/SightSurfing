//
//  ListViewContainerProtocol.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/22.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit

protocol ListViewHostProtocol: AnyObject {
    func insert(at indices: [Int])
    func setupLoading(_ isLoading: Bool)
}

extension ListViewHostProtocol where Self: UITableViewController {
    func insert(at indices: [Int]) {
        let indexPaths = indices.map { IndexPath(row: $0, section: 0) }
        let contentOffset = tableView.contentOffset
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .fade)
        tableView.endUpdates()
        tableView.setContentOffset(contentOffset, animated: false)
    }

    func setupLoading(_ isLoading: Bool) {
        if tableView.tableFooterView == nil {
            tableView.tableFooterView = PhotoListFooterLoadingView()
        }
        tableView.tableFooterView?.isHidden = !isLoading
    }
}

extension ListViewHostProtocol where Self: UICollectionViewController {
    func insert(at indices: [Int]) {
        let indexPaths = indices.map { IndexPath(row: $0, section: 0) }
        collectionView.performBatchUpdates({ [weak self] in
            self?.collectionView.insertItems(at: indexPaths)
            }, completion: nil)
    }
}
