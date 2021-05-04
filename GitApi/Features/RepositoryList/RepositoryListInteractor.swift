//
//  RepositoryListInteractor.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import Foundation

class RepositoryListInteractor {
    var api = APIRequestMaker()
    private var isFetching: Bool = false

    weak var output: RepositoryListInteractorOutput?
}

extension RepositoryListInteractor: RepositoryListInteractorInput {
    func fetchData(forPage page: Int) {
        guard isFetching == false else {
            output?.fetchRequestIgnored(onPage: page)
            return
        }

        isFetching = true

        api.request(with: .list(language: "Swift", page: page)) { [weak self] (result: Result<RepositoryListModel, APIError>) in
            self?.isFetching = false
            switch result {
            case .success(let data):
                self?.output?.dataFetched(data, forPage: page)
            case .failure(let error):
                self?.output?.error(message: error.localizedDescription)
            }
        }
    }
}
