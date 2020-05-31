//
//  RepositoryListPresenterUnitTests.swift
//  GitApiTests
//
//  Created by Elias Medeiros on 30/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import XCTest
@testable import GitApi

class RepositoryListPresenterUnitTests: XCTestCase {
    func testExample() {
        // given a instance of presenter
        let presenter = RepositoryListPresenter()

        // expect
        XCTAssert(presenter.itemCount == 0, "Empty data must result on item count 0")

        // when we add lots of repos to the list
        presenter.repositories.append(contentsOf: repeatElement(MockedData.repository, count: 300))

        // then
        XCTAssert(presenter.itemCount == 301, "Must leave a blank item for reloading purposes")

        // when we extrapolate the number of items
        presenter.repositories.append(contentsOf: repeatElement(MockedData.repository, count: 1000))

        // then
        XCTAssert(presenter.itemCount == 1000, "The api limitation is handled")
    }
}
