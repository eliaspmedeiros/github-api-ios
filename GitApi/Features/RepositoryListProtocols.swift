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
    
}

// presenter -> view
protocol RepositoryListViewInterface: AnyObject {
    func reload()
    func reload(indexes: [IndexPath])
    func showActivityIndicator()
    func hideActivityIndicator()
}

// view -> presenter
protocol RepositoryListModuleInterface {
    func viewDidLoad()
    func refreshAction()
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
