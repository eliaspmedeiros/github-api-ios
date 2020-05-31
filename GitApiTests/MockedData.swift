//
//  MockedData.swift
//  GitApiTests
//
//  Created by Elias Medeiros on 30/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import Foundation
@testable import GitApi

struct MockedData {
    static let owner = Owner(name: "Test Owner", picture: "")
    static let repository = RepositoryModel(id: 0, name: "Repo test", starCount: 1, owner: owner)
    static let repositoryList = RepositoryListModel(totalCount: 1, items: [repository])
}
