//
//  RepositoryListViewController.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit

class RepositoryListViewController: UIViewController {
    typealias Presenter = RepositoryListModuleInterface & UITableViewDataSource & UITableViewDataSourcePrefetching
    var presenter: Presenter!

    var tableView: UITableView? {
        view as? UITableView
    }

    private var refreshControl = UIRefreshControl()

    // MARK: life cycle
    override func loadView() {
        view = UITableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()

        tableView?.register(RespositoryTableViewCell.self, forCellReuseIdentifier: RespositoryTableViewCell.cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = presenter
        tableView?.prefetchDataSource = presenter
        tableView?.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
    }


    @objc func onRefresh() {
        presenter.refreshAction()
    }
}

extension RepositoryListViewController: RepositoryListViewInterface {
    func reload() {
        tableView?.reloadData()
    }

    func reload(indexes: [IndexPath]) {
        tableView?.reloadRows(at: indexes, with: .fade)
    }

    func showActivityIndicator() {

    }

    func hideActivityIndicator() {
        refreshControl.endRefreshing()
    }
}

extension RepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
