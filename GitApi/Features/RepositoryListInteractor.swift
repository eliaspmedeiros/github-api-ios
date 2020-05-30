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

    weak var output: RepositoryListInteractorOutput?
}

extension RepositoryListInteractor: RepositoryListInteractorInput {
    func fetchData() {
        api.request(with: .list(language: "Swift", sorting: "stars")) { [weak self] (result: Result<RepositoryListModel, APIError>) in
            switch result {
            case .success(let data):
                self?.output?.dataFetched(data)
            case .failure(let error):
                self?.output?.error(message: error.localizedDescription)
            }
        }
    }
}
