//
//  PhotoListViewController.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/9.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit

class PhotoListViewController: UITableViewController, ListViewHostProtocol {
    private var footer: UITableViewHeaderFooterView?

    private var controller: PhotoListController

    init(controller: PhotoListController = PhotoListController()) {
        self.controller = controller
        super.init(style: .grouped)
        controller.listViewHost = self
        initView()
        initTableView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initTableView() {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableFooterView = PhotoListFooterLoadingView()
        tableView.register(PhotoListTabelViewCell.self, forCellReuseIdentifier: PhotoListTabelViewCell.uniqueIdentifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.start()
    }

    private func initView() {
        view.backgroundColor = .white
    }

    // MARK: TableView datasource & delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.container.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = controller.container[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTabelViewCell.uniqueIdentifier, for: indexPath) as? PhotoListTabelViewCell else {
            assert(false, "Unhandled tableview cell")
            return UITableViewCell()
        }

        cell.setup(viewModel: cellViewModel)
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        controller.willScrollTo(index: indexPath.row)
    }
}
