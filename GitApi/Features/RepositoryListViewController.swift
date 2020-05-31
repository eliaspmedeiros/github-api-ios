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

        tableView?.separatorStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.moduleDidLoad()
        setupTableView()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        title = "Repositórios - Swift"
    }

    @objc func onRefresh() {
        presenter.refreshAction()
    }

    private func setupTableView() {
        tableView?.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.cellIdentifier)
        tableView?.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = presenter
        tableView?.prefetchDataSource = presenter
        tableView?.refreshControl = refreshControl
    }
}

extension RepositoryListViewController: RepositoryListViewInterface {
    func reload() {
        tableView?.separatorStyle = .singleLine
        tableView?.reloadData()
    }

    func showActivityIndicator() {
        
    }

    func hideActivityIndicator() {
        refreshControl.endRefreshing()
    }

    func displayError(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)

        let mainAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            alert.dismiss(animated: true)
        }

        alert.addAction(mainAction)

        present(alert, animated: true)
    }
}

extension RepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
