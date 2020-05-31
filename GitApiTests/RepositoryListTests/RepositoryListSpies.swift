//
//  RepositoryListSpies.swift
//  GitApiTests
//
//  Created by Elias Medeiros on 30/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import Foundation
@testable import GitApi

class RepositoryListViewSpy: RepositoryListViewInterface {
    var hasCalledReload = false
    var hasCalledErrorDisplay = false

    func reload() {
        hasCalledReload = true
    }

    func showActivityIndicator() {

    }

    func hideActivityIndicator() {

    }

    func displayError(message: String) {
        hasCalledErrorDisplay = true
    }
}

class RepositoryListInteractorSpy: RepositoryListInteractorInput {
    enum DesiredResult {
        case success(result: RepositoryListModel)
        case failure
    }

    var desiredResult: DesiredResult!
    var output: RepositoryListInteractorOutput

    internal init(output: RepositoryListInteractorOutput) {
        self.output = output
    }

    var lastRequestedPage = 0

    func fetchData(forPage page: Int) {
        lastRequestedPage = page
        switch desiredResult {
        case .success(let result):
            output.dataFetched(result, forPage: page)
        case .failure:
            output.error(message: "error")
        case .none:
            break
        }
    }
}
