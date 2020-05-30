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
    func reload(title: String)
}

// view -> presenter
protocol RepositoryListModuleInterface {
    func viewDidLoad()
}

// presenter -> interactor
protocol RepositoryListInteractorInput {
    func fetchData()
}

// interactor -> presenter
protocol RepositoryListInteractorOutput: AnyObject {
    func dataFetched(_: RepositoryListModel)
    func error(message: String)
}
