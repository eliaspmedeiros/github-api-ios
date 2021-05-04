//
//  RepositoryDetailRouter.swift
//  GitApi
//
//  Created by Elias Medeiros on 04/05/21.
//  Copyright © 2021 Corp. All rights reserved.
//

import UIKit

class RepositoryDetailRouter {
    weak var navigationController: UINavigationController?
}

extension RepositoryDetailRouter: RepositoryDetailRouterInterface {
}

// MARK: builder
extension RepositoryDetailRouter {
    class func createModule(using navigationController: UINavigationController, andRepoId repoId: Int) -> UIViewController {
        let router = RepositoryDetailRouter()
        let presenter = RepositoryDetailPresenter(repoId: repoId)
        let view = RepositoryDetailViewController()
        let interactor = RepositoryDetailInteractor()

        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter
        router.navigationController = navigationController

        return view
    }
}
