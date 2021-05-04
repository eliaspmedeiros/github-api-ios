//
//  RepositoryDetailPresenter.swift
//  GitApi
//
//  Created by Elias Medeiros on 04/05/21.
//  Copyright © 2021 Corp. All rights reserved.
//

import Foundation

class RepositoryDetailPresenter {
    weak var view: RepositoryDetailViewInterface?
    var router: RepositoryDetailRouterInterface?
    var interactor: RepositoryDetailInteractorInput?

    let repoId: Int

    init(repoId: Int) {
        self.repoId = repoId
    }
}

extension RepositoryDetailPresenter: RepositoryDetailModuleInterface {
}

extension RepositoryDetailPresenter: RepositoryDetailInteractorOutput {
}
