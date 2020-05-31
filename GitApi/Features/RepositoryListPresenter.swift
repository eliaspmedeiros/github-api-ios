//
//  RepositoryListPresenter.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit

class RepositoryListPresenter: NSObject {
    weak var view: RepositoryListViewInterface?
    var router: RepositoryListRouterInterface?
    var interactor: RepositoryListInteractorInput?

    // This should be determined by the response total count;
    // but the GitHub API has a limitation as described when trying to fetch a late page:
    // status: 422, message: "Only the first 1000 search results are available"
    var totalCount = 1000
    var repositories: [RepositoryModel] = []
    var currentPage = 1

    private func calculateIndexPathsToReload(from newData: [RepositoryModel]) -> [IndexPath] {
        let startIndex = repositories.count - newData.count
        let endIndex = startIndex + newData.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

extension RepositoryListPresenter: RepositoryListModuleInterface {
    func viewDidLoad() {
        view?.showActivityIndicator()
        interactor?.fetchData(forPage: currentPage)
    }

    func refreshAction() {
        currentPage = 1
        interactor?.fetchData(forPage: currentPage)
    }
}

extension RepositoryListPresenter: RepositoryListInteractorOutput {
    func dataFetched(_ data: RepositoryListModel, forPage page: Int) {
        print("Retornando dados \(data.items.count), página: \(page), \(data.items.first!.name)")
        repositories.append(contentsOf: data.items)
        self.currentPage = page + 1

        DispatchQueue.main.async {
            self.view?.hideActivityIndicator()

            if page > 1 {
                self.view?.reload(indexes: self.calculateIndexPathsToReload(from: data.items))
            } else {
                self.view?.reload()
            }
        }
    }

    func fetchRequestIgnored(onPage: Int) {
        print("Ignorando fetch request")
    }

    func error(message: String) {
        DispatchQueue.main.async {
            self.view?.hideActivityIndicator()
        }
    }
}

extension RepositoryListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RespositoryTableViewCell.cellIdentifier, for: indexPath)

        if let repositoryCell = cell as? RespositoryTableViewCell,
            let repositoryInstance = repositories[safe: indexPath.row] {
            repositoryCell.config(with: repositoryInstance)
        }

        return cell
    }
}

extension RepositoryListPresenter: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            interactor?.fetchData(forPage: currentPage)
        }
    }

    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= repositories.count
    }
}
