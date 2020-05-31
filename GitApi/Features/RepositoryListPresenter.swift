//
//  RepositoryListPresenter.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit

class RepositoryListPresenter: NSObject {
    // MARK: viper support
    weak var view: RepositoryListViewInterface?
    var router: RepositoryListRouterInterface?
    var interactor: RepositoryListInteractorInput?

    // MARK: data
    var repositories: [RepositoryModel] = []

    // MARK: - table and pagination
    /// This should be determined by the response total count;
    /// but the GitHub API has a limitation as described when trying to fetch a late page:
    /// status: 422, message: "Only the first 1000 search results are available"
    var hardLimit = 1000
    var nextPage = 1
    var itemCount: Int {
        let count = repositories.hasElements ? repositories.count + 1 : 0

        return min(hardLimit, count)
    }
}

extension RepositoryListPresenter: RepositoryListModuleInterface {
    func moduleDidLoad() {
        view?.showActivityIndicator()
        interactor?.fetchData(forPage: nextPage)
    }

    func refreshAction() {
        nextPage = 1
        interactor?.fetchData(forPage: nextPage)
    }
}

extension RepositoryListPresenter: RepositoryListInteractorOutput {
    func dataFetched(_ data: RepositoryListModel, forPage page: Int) {
        repositories.append(contentsOf: data.items)
        nextPage = page + 1

        DispatchQueue.main.async {
            self.view?.hideActivityIndicator()

            self.view?.reload()
        }
    }

    func fetchRequestIgnored(onPage: Int) { }

    func error(message: String) {
        DispatchQueue.main.async {
            self.view?.hideActivityIndicator()
            self.view?.displayError(message: "Erro interno. Decidimos culpar a API do github, agradecemos pela compreensão")
        }
    }
}

extension RepositoryListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let repositoryInstance = repositories[safe: indexPath.row] else {
            return tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.cellIdentifier, for: indexPath)
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.cellIdentifier, for: indexPath)

        if let repositoryCell = cell as? RepositoryTableViewCell {
            repositoryCell.config(with: repositoryInstance)
        }

        return cell
    }
}

extension RepositoryListPresenter: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            interactor?.fetchData(forPage: nextPage)
        }
    }

    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= repositories.count
    }
}
