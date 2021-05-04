//
//  RepositoryListProtocols.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import Foundation

// presenter -> router
// world -> router
protocol RepositoryListRouterInterface {
    func navigateToRepositoryDetail(repoId: Int)
}

// presenter -> view
protocol RepositoryListViewInterface: AnyObject {
    func reload()
    func showActivityIndicator()
    func hideActivityIndicator()
    func displayError(message: String)
}

// view -> presenter
protocol RepositoryListModuleInterface {
    func moduleDidLoad()
    func refreshAction()
    func itemSelected(atRow: Int)
}

// presenter -> interactor
protocol RepositoryListInteractorInput {
    func fetchData(forPage: Int)
}

// interactor -> presenter
protocol RepositoryListInteractorOutput: AnyObject {
    func dataFetched(_: RepositoryListModel, forPage: Int)
    func fetchRequestIgnored(onPage: Int)
    func error(message: String)
}
