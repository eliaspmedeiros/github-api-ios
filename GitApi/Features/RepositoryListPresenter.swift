//
//  RepositoryListPresenter.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import Foundation

class RepositoryListPresenter {
    weak var view: RepositoryListViewInterface?
    var router: RepositoryListRouterInterface?
    var interactor: RepositoryListInteractorInput?
}

extension RepositoryListPresenter: RepositoryListModuleInterface {
    func viewDidLoad() {
        interactor?.fetchData()
    }
}

extension RepositoryListPresenter: RepositoryListInteractorOutput {
    func dataFetched(_ data: RepositoryListModel) {
        if let first = data.items.first {
            DispatchQueue.main.async {
                self.view?.reload(title: first.name)
            }
        }
    }

    func error(message: String) {
        
    }
}
