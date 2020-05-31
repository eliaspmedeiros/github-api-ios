//
//  RepositoryListPresenterBehaviorTests.swift
//  GitApiTests
//
//  Created by Elias Medeiros on 30/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import Nimble
import Quick
@testable import GitApi

class RepositoryListPresenterBehaviorTests: QuickSpec {
    override func spec() {
        var presenter: RepositoryListPresenter!
        var view: RepositoryListViewSpy!
        var interactor: RepositoryListInteractorSpy!

        func clearInteractor() {
            interactor = .init(output: presenter)
            presenter.interactor = interactor
        }

        func clearView() {
            view = .init()
            presenter.view = view
        }

        beforeEach {
            presenter = RepositoryListPresenter()

            clearView()
            clearInteractor()
        }

        describe("presenter exists") {
            context("when loading the module") {
                context("everything is fine") {
                    beforeEach {
                        interactor.desiredResult = .success(result: MockedData.repositoryList)
                        presenter.moduleDidLoad()
                    }

                    it("data must be fetched for page 1") {
                        expect(interactor.lastRequestedPage) == 1
                    }

                    it("and view reload must be called after fetching data") {
                        expect(view.hasCalledReload).toEventually(equal(true))
                    }
                }

                context("an error is received from interactor") {
                    beforeEach {
                        interactor.desiredResult = .failure
                        presenter.moduleDidLoad()
                    }
                    it("the view must be warned") {
                        expect(view.hasCalledErrorDisplay).toEventually(equal(true))
                    }
                }
            }

            context("when refreshing") {
                beforeEach {
                    interactor.desiredResult = .success(result: MockedData.repositoryList)
                    presenter.moduleDidLoad()
                }

                it("must request first page and get ready to ask for second") {
                    interactor.fetchData(forPage: 4)
                    expect(presenter.nextPage) == 5

                    presenter.refreshAction()
                    expect(interactor.lastRequestedPage) == 1
                    expect(presenter.nextPage) == 2
                }
            }
        }
    }

}
