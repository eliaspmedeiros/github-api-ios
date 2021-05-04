//
//  RepositoryDetailProtocols.swift
//  GitApi
//
//  Created by Elias Medeiros on 04/05/21.
//  Copyright © 2021 Corp. All rights reserved.
//

import Foundation

// presenter -> router
// world -> router
protocol RepositoryDetailRouterInterface {
}

// presenter -> view
protocol RepositoryDetailViewInterface: AnyObject {
}

// view -> presenter
protocol RepositoryDetailModuleInterface {
}

// presenter -> interactor
protocol RepositoryDetailInteractorInput {
}

// interactor -> presenter
protocol RepositoryDetailInteractorOutput: AnyObject {
}
