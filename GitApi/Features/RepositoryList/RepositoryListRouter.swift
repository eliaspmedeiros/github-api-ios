//
//  RepositoryListRouter.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit

class RepositoryListRouter {
    weak var navigationController: UINavigationController?
}

extension RepositoryListRouter: RepositoryListRouterInterface {
    func navigateToRepositoryDetail(repoId: Int) {
        if let navigation = navigationController {
            let viewController = RepositoryDetailRouter.createModule(using: navigation, andRepoId: repoId)
            navigation.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: builder
extension RepositoryListRouter {
    class func createModule(using navigationController: UINavigationController) -> UIViewController {
        let router = RepositoryListRouter()
        let presenter = RepositoryListPresenter()
        let view = RepositoryListViewController()
        let interactor = RepositoryListInteractor()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter
        router.navigationController = navigationController
        
        return view
    }
}
